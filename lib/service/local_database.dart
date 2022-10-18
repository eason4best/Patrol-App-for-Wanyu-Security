import 'dart:math';

import 'package:path/path.dart';
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/model/api_exception.dart';
import 'package:security_wanyu/model/customer.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/patrol_record.dart';
import 'package:security_wanyu/model/place2patrol.dart';
import 'package:security_wanyu/model/punch_card_record.dart';
import 'package:security_wanyu/other/utils.dart';
import 'package:security_wanyu/service/etun_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vector_math/vector_math.dart';

class LocalDatabase {
  LocalDatabase._constructor();
  static final LocalDatabase instance = LocalDatabase._constructor();

  Future<Database> get _db async => await openDatabase(
        join(await getDatabasesPath(), 'etun.db'),
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE Member (
              patrol_member_id INTEGER NOT NULL PRIMARY KEY,
              member_account TEXT NOT NULL,
              member_password TEXT NOT NULL,
              member_name TEXT NOT NULL,
              member_sn TEXT NOT NULL
            )
            ''');
          await db.execute('''
            CREATE TABLE Customer (
              customer_id INTEGER NOT NULL,
              firstname TEXT NOT NULL,
              lat REAL NOT NULL,
              lng REAL NOT NULL
            )
            ''');
          await db.execute(
            '''
            CREATE TABLE PunchCardRecord (
              rec_id INTEGER PRIMARY KEY AUTOINCREMENT,
              patrol_member_id INTEGER NOT NULL,
              member_sn TEXT NOT NULL,
              member_name TEXT NOT NULL,
              date_time TEXT,
              punch_card_type TEXT NOT NULL,
              makeup_type TEXT,
              customer_id INTEGER,
              customer_name TEXT NOT NULL,
              lat REAL,
              lng REAL,
              uploaded INTEGER DEFAULT 0
            )
            ''',
          );
          await db.execute(
            '''
            CREATE TABLE Place2Patrol (
                  patrolPlaceSN TEXT NOT NULL,
                  patrolPlaceTitle TEXT NOT NULL,
                  customerId INTEGER NOT NULL,
                  customerName TEXT NOT NULL,
                  day INTEGER NOT NULL,
                  shiftTime TEXT NOT NULL
                  )
            ''',
          );
          await db.execute(
            '''
                CREATE TABLE PatrolRecord (
                  rec_id INTEGER PRIMARY KEY AUTOINCREMENT,
                  customerId INTEGER NOT NULL,
                  memberSN TEXT NOT NULL,
                  memberName TEXT NOT NULL,
                  patrolPlaceSN TEXT NOT NULL,
                  patrolPlaceTitle TEXT NOT NULL,
                  patrolDateTime TEXT NOT NULL,
                  patrolDateTimeInMS INTEGER NOT NULL,
                  day INTEGER NOT NULL,
                  uploaded INTEGER DEFAULT 0
                )
            ''',
          );
        },
      );

  Future<void> insertMember({required Member member}) async {
    Database db = await _db;
    await db.insert('Member', member.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<Member> getMember() async {
    Database db = await _db;
    List<Map<String, Object?>> maps = await db.query('Member', limit: 1);
    if (maps.isNotEmpty) {
      return Member.fromMap(maps.first);
    } else {
      throw APIException(code: 'no-local-member', message: '沒有本地的會員資料');
    }
  }

  Future<void> insertCustomers({required List<Customer> customers}) async {
    Database db = await _db;
    Batch batch = db.batch();
    for (var c in customers) {
      batch.insert('Customer', c.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List<Customer>> getCustomers() async {
    Database db = await _db;
    List<Map<String, dynamic>> customers = await db.query('Customer');
    return customers.map((data) => Customer.fromMap(data)).toList();
  }

  Future<Customer> getNearesCustomer(
      {required double lat, required double lng}) async {
    List<Customer> customers = await getCustomers();
    double distanceToCustomer(customerLat, customerLng) =>
        6371000 *
        acos(cos(radians(lat)) *
                cos(radians(customerLat)) *
                cos(radians(customerLng) - radians(lng)) +
            sin(radians(lat)) * sin(radians(customerLat)));
    customers.sort((a, b) => distanceToCustomer(a.lat, a.lng)
        .compareTo(distanceToCustomer(b.lat, b.lng)));
    if (distanceToCustomer(customers.first.lat, customers.first.lng) < 500) {
      return customers.first;
    } else {
      throw APIException(code: 'no-nearby-customer', message: '請前往上班地點再進行打卡');
    }
  }

  Future<void> deleteCustomers() async {
    Database db = await _db;
    await db.delete('Customer');
  }

  Future<void> replaceCustomers({required List<Customer> customers}) async {
    await deleteCustomers();
    await insertCustomers(customers: customers);
  }

  Future<void> punchCard({required PunchCardRecord punchCardRecord}) async {
    try {
      if (punchCardRecord.punchCardType != PunchCards.makeUp) {
        Customer nearestCustomer = await getNearesCustomer(
            lat: punchCardRecord.lat!, lng: punchCardRecord.lng!);
        List<int> customerIds =
            await getCustomers2Patrol(day: DateTime.now().day);
        if (customerIds.isEmpty) {
          throw APIException(code: 'no_shift_today', message: '本日無執勤');
        }
        if (!customerIds.contains(nearestCustomer.customerId)) {
          throw APIException(code: 'at_wrong_customer', message: '請在班表安排的地點打卡');
        }
        punchCardRecord.setCustomerId = nearestCustomer.customerId;
        punchCardRecord.setCustomerName = nearestCustomer.customerName;
      }
      Database db = await _db;
      await db.insert('PunchCardRecord', punchCardRecord.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadLocalPunchCardRecords() async {
    if (await Utils.hasInternetConnection()) {
      Database db = await _db;
      List<Map<String, dynamic>> maps =
          await db.query('PunchCardRecord', where: 'uploaded = 0');
      for (var map in maps) {
        PunchCardRecord punchCardRecord = PunchCardRecord.fromMap(map);
        await EtunAPI.instance.punchCard(punchCardRecord: punchCardRecord);
        await db.rawUpdate(
          '''
        UPDATE PunchCardRecord
        SET uploaded = 1
        WHERE rec_id = ?
        ''',
          [map['rec_id']],
        );
      }
    }
  }

  Future<int> getUpcomingPatrolCustomer() async {
    try {
      Database db = await _db;
      List<Map<String, dynamic>> maps = await db.rawQuery(
        '''
      SELECT customer_id, punch_card_type
        FROM PunchCardRecord
        WHERE punch_card_type != '補卡'
        ORDER BY rec_id DESC
        LIMIT 1
      ''',
      );
      if (maps.isNotEmpty) {
        PunchCardRecord punchCardRecord = PunchCardRecord.fromMap(maps.first);
        if (punchCardRecord.punchCardType == PunchCards.work) {
          return punchCardRecord.customerId!;
        }
      }
      throw APIException(code: 'not-on-duty', message: '請先打卡上班後再開始巡邏');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> replacePlaces2Patrol(
      {required List<Place2Patrol> places2Patrol}) async {
    await deletePlaces2Patrol();
    await insertPlaces2Patrol(places2Patrol: places2Patrol);
  }

  Future<void> insertPlaces2Patrol(
      {required List<Place2Patrol> places2Patrol}) async {
    Database db = await _db;
    Batch batch = db.batch();
    for (var pp in places2Patrol) {
      batch.insert('Place2Patrol', pp.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List<Place2Patrol>> getPlaces2Patrol({int? day}) async {
    Database db = await _db;
    List<Map<String, dynamic>> maps = await db.query(
      'Place2Patrol',
      columns: null,
      where: day != null ? 'day = ?' : null,
      whereArgs: day != null ? [day] : null,
    );
    return maps.map((map) => Place2Patrol.fromMap(map)).toList();
  }

  Future<List<Place2Patrol>> getDonePlaces2Patrol(
      {required int customerId}) async {
    Database db = await _db;
    List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT pp.* FROM Place2Patrol pp 
      INNER JOIN PatrolRecord pr 
      ON pp.patrolPlaceSN = pr.patrolPlaceSN 
      AND pp.day = pr.day
      WHERE pp.day = ? AND pp.customerId = ? AND pr.patrolDateTimeInMS > ?
      ''',
      [
        DateTime.now().day,
        customerId,
        DateTime.now()
            .subtract(const Duration(minutes: 10))
            .millisecondsSinceEpoch
      ],
    );
    return maps.map((map) => Place2Patrol.fromMap(map)).toList();
  }

  Future<List<Place2Patrol>> getUndonePlaces2Patrol(
      {required int customerId}) async {
    Database db = await _db;
    List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT pp.* FROM Place2Patrol pp 
      LEFT JOIN PatrolRecord pr 
      ON pp.patrolPlaceSN = pr.patrolPlaceSN 
      AND pp.day = pr.day
      WHERE (pp.day = ? AND pp.customerId = ?) 
      AND ((pr.patrolPlaceSN IS NULL AND pr.day IS NULL) OR pr.patrolDateTimeInMS < ?)
      ''',
      [
        DateTime.now().day,
        customerId,
        DateTime.now()
            .subtract(const Duration(minutes: 10))
            .millisecondsSinceEpoch
      ],
    );
    return maps.map((map) => Place2Patrol.fromMap(map)).toList();
  }

  Future<void> deletePlaces2Patrol() async {
    Database db = await _db;
    await db.delete('Place2Patrol');
  }

  Future<List<int>> getCustomers2Patrol({int? day}) async {
    List<Place2Patrol> places2Patrol = await getPlaces2Patrol(day: day);
    return Set<int>.from(places2Patrol.map((pp) => pp.customerId)).toList();
  }

  Future<void> insertPatrolRecord({required PatrolRecord patrolRecord}) async {
    Database db = await _db;
    await db.insert('PatrolRecord', patrolRecord.toMap());
  }

  Future<void> uploadLocalPatrolRecords() async {
    if (await Utils.hasInternetConnection()) {
      Database db = await _db;
      List<Map<String, dynamic>> maps =
          await db.query('PatrolRecord', where: 'uploaded = 0');
      for (var map in maps) {
        PatrolRecord patrolRecord = PatrolRecord.fromMap(map);
        await EtunAPI.instance.uploadPatrolRecord(patrolRecord: patrolRecord);
        await db.rawUpdate(
          '''
        UPDATE PatrolRecord
        SET uploaded = 1
        WHERE rec_id = ?
        ''',
          [map['rec_id']],
        );
      }
    }
  }
}

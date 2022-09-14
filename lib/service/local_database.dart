import 'package:path/path.dart';
import 'package:security_wanyu/model/patrol_record.dart';
import 'package:security_wanyu/model/place2patrol.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._constructor();
  static final LocalDatabase instance = LocalDatabase._constructor();

  Future<Database> get _db async => await openDatabase(
        join(await getDatabasesPath(), 'etun.db'),
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
            '''CREATE TABLE Place2Patrol (
                  patrolPlaceSN TEXT NOT NULL,
                  patrolPlaceTitle TEXT NOT NULL,
                  customerId INTEGER NOT NULL,
                  customerName TEXT NOT NULL,
                  day INTEGER NOT NULL,
                  PRIMARY KEY (patrolPlaceSN, day)
                  )
            ''',
          );
          await db.execute(
            '''
                CREATE TABLE PatrolRecord (
                  customerId INTEGER NOT NULL,
                  memberSN TEXT NOT NULL,
                  memberName TEXT NOT NULL,
                  patrolPlaceSN TEXT NOT NULL,
                  patrolPlaceTitle TEXT NOT NULL,
                  day INTEGER NOT NULL,
                  uploaded INTEGER NOT NULL
                )
            ''',
          );
        },
      );

  Future<void> insertPlaces2Patrol(
      {required List<Place2Patrol> places2Patrol}) async {
    Database db = await _db;
    Batch batch = db.batch();
    for (var pp in places2Patrol) {
      batch.insert('Place2Patrol', pp.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<void> replaceAllPlaces2Patrol(
      {required List<Place2Patrol> places2Patrol}) async {
    await deletePlaces2Patrol();
    await insertPlaces2Patrol(places2Patrol: places2Patrol);
  }

  Future<List<Place2Patrol>> getPlaces2Patrol({int? day}) async {
    Database db = await _db;
    List<Map<String, dynamic>> maps = await db.query(
      'Place2Patrol',
      columns: null,
      where: day != null ? 'day = ?' : null,
      whereArgs: day != null ? [DateTime.now().day] : null,
    );
    return maps.map((map) => Place2Patrol.fromMap(map)).toList();
  }

  Future<List<Place2Patrol>> getDonePlaces2Patrol() async {
    Database db = await _db;
    List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT pp.* FROM Place2Patrol pp 
      INNER JOIN PatrolRecord pr 
      ON pp.patrolPlaceSN = pr.patrolPlaceSN 
      AND pp.day = pr.day
      WHERE pp.day = ?
      ''',
      [DateTime.now().day],
    );
    return maps.map((map) => Place2Patrol.fromMap(map)).toList();
  }

  Future<List<Place2Patrol>> getUndonePlaces2Patrol() async {
    Database db = await _db;
    List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
      SELECT pp.* FROM Place2Patrol pp 
      LEFT JOIN PatrolRecord pr 
      ON pp.patrolPlaceSN == pr.patrolPlaceSN 
      AND pp.day == pr.day
      WHERE pp.day = ? AND pr.patrolPlaceSN IS NULL AND pr.day IS NULL
      ''',
      [DateTime.now().day],
    );
    return maps.map((map) => Place2Patrol.fromMap(map)).toList();
  }

  Future<void> deletePlaces2Patrol({int? day}) async {
    Database db = await _db;
    await db.delete(
      'Place2Patrol',
      where: day != null ? 'day = ?' : null,
      whereArgs: day != null ? [DateTime.now().day] : null,
    );
  }

  Future<void> insertPatrolRecord(
      {required List<PatrolRecord> patrolRecord}) async {
    Database db = await _db;
    Batch batch = db.batch();
    for (var pr in patrolRecord) {
      batch.insert('PatrolRecord', pr.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List<PatrolRecord>> getPatrolRecordsToUpload() async {
    Database db = await _db;
    List<Map<String, dynamic>> maps =
        await db.query('PatrolRecord', where: 'uploaded = ?', whereArgs: [0]);
    return maps.map((map) => PatrolRecord.fromMap(map)).toList();
  }
}

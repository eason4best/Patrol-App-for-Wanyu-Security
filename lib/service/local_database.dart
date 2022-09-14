import 'package:path/path.dart';
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
                  patrolPlaceTitle TEXT NOT NULL
                )
            ''',
          );
        },
      );

  Future<void> insertPlaces2Patrol(
      {required List<Place2Patrol> places2Patrol}) async {
    Database db = await _db;
    await db.delete('Place2Patrol');
    Batch batch = db.batch();
    for (var pp in places2Patrol) {
      batch.insert('Place2Patrol', pp.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List<Place2Patrol>> getPlaces2Patrol({bool wholeMonth = false}) async {
    Database db = await _db;
    if (wholeMonth) {
      List<Map<String, dynamic>> maps =
          await db.query('Place2Patrol', columns: null);
      return maps.map((map) => Place2Patrol.fromMap(map)).toList();
    } else {
      List<Map<String, dynamic>> maps = await db.query(
        'Place2Patrol',
        columns: null,
        where: 'day = ?',
        whereArgs: [DateTime.now().day],
      );
      return maps.map((map) => Place2Patrol.fromMap(map)).toList();
    }
  }
}

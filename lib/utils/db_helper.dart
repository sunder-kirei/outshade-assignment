import 'package:outshade_assignment/models/db_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const tableName = "user";

  static Future<Database> get getDb async {
    final db = await openDatabase(
      "user.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE ${DBHelper.tableName} (uid INTEGER PRIMARY KEY, age INTEGER, gender INTEGER)",
        );
      },
    );
    return db;
  }

  static Future<int> insert({
    required DbData data,
  }) async {
    final db = await getDb;

    final id = await db.insert(
      DBHelper.tableName,
      data.dataMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<int> remove({
    required DbData data,
  }) async {
    final db = await getDb;

    final id = await db.delete(
      DBHelper.tableName,
      where: "uid = ?",
      whereArgs: [data.uid],
    );
    return id;
  }

  static Future<List<DbData>> get allUsers async {
    final db = await getDb;
    final fetchedData = await db.query(
      DBHelper.tableName,
    );

    final dbDataList = fetchedData
        .map(
          (dataMap) => DbData.fromMap(dataMap: dataMap),
        )
        .toList();
    return dbDataList;
  }

  static Future<DbData?> getUserByUID({required int uid}) async {
    final db = await getDb;
    final fetchedData = await db.query(
      DBHelper.tableName,
      where: "uid = ?",
      whereArgs: [uid],
    );

    if (fetchedData.isEmpty) {
      return null;
    }

    return DbData.fromMap(
      dataMap: fetchedData.first,
    );
  }
}

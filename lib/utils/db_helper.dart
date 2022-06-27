import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

final dbProvider = Provider((ref) {
  return DataBaseProvider();
});

class DataBaseProvider {
  static const tableName = 'scheduleTable2';

  static Future database() async {
    final databasePath = await sql.getDatabasesPath();

    return sql.openDatabase(path.join(databasePath, 'schedules.db'),
        onCreate: (db, version) {
      return db.execute('''CREATE TABLE IF NOT EXISTS $tableName (
            id INT PRIMARY KEY,
            title TEXT,
            time TEXT, 
            mode TEXT,
            active INT,
            volume INT
            )''');
    }, version: 2);
  }

  Future<void> insert(Map<String, Object> data) async {
    final db = await DataBaseProvider.database();
    await db.insert(tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final db = await DataBaseProvider.database();

    return await db.query(tableName);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    final db = await DataBaseProvider.database();
    await db.update(tableName, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> delete(String id) async {
    final db = await DataBaseProvider.database();

    await db.delete(tableName, where: "id=?", whereArgs: [id]);
  }
}

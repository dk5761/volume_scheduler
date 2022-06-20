import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DBHelper {
  static Future database() async {
    final databasePath = await getDatabasesPath();

    return openDatabase(join(databasePath, 'schedules.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE notes(id TEXT PRIMARY KEY, title TEXT, dt datetime, mode TEXT)");
    }, version: 1);
  }

  static Future insert(Map<String, dynamic> data) async {
    final database = await DBHelper.database();
    // print("data $data");
    database.insert("schedules", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future update(String id, Map<String, dynamic> data) async {
    final database = await DBHelper.database();

    database.update("schedules", data, where: 'id = ?', whereArgs: [id]);
  }

  static Future delete(String id) async {
    final database = await DBHelper.database();

    return database.delete("schedules", where: "id=?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getAllItems() async {
    final db = await DBHelper.database();

    return db.query("schedules", orderBy: "dt DESC");
  }
}

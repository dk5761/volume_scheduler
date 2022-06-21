import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

final dbProvider = ChangeNotifierProvider<DataBaseProvider>((ref) {
  return DataBaseProvider();
});

class DataBaseProvider with ChangeNotifier {
  static const tableName = 'schedule';
  late sql.Database db;

  DataBaseProvider() {
    // this will run when provider is instantiate the first time
    init();
  }

  void init() async {
    final dbPath = await sql.getDatabasesPath();
    db = await sql.openDatabase(
      path.join(dbPath, 'schedules.db'),
      onCreate: (db, version) {
        final stmt = '''CREATE TABLE IF NOT EXISTS $tableName (
            id TEXT PRIMARY KEY,
            title TEXT,
            dt datetime, 
            mode TEXT
        )'''
            .trim()
            .replaceAll(RegExp(r'[\s]{2,}'), ' ');
        return db.execute(stmt);
      },
      version: 1,
    );
    // the init funciton is async so it won't block the main thread
    // notify provider that depends on it when done
    notifyListeners();
  }

  Future<void> insert(Map<String, Object> data) async {
    await db.insert(tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    return await db.query(tableName);
  }

  Future<void> delete(String id) async {
    await db.delete(tableName, where: "id=?", whereArgs: [id]);
  }
}

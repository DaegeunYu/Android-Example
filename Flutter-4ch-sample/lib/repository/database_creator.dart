import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseCreator {
  static const videoStateTable = 'videoState';
  static const id = 'id';
  static const mainScreen = 'mainScreen';

  static void databaseLog(String functionName, String sql, [List<Map<String, dynamic>> selectQueryResult]) {
    print(functionName);
    print(sql);
    if (selectQueryResult != null) {
      print(selectQueryResult);
    }
  }

  Future<void> createTodoTable(Database db) async {
    final videoSql = '''CREATE TABLE $videoStateTable
    (
      $id INTEGER PRIMARY KEY,
      $mainScreen INTEGER
    )''';

    await db.execute(videoSql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('videoState');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createTodoTable(db);
  }
}

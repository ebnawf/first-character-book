import 'dart:io';
import 'package:first_character_book/models/poem_model.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../tools/consts.dart';

class DbHelper {
  static Future<Database> get database async {
    final String databasesPath = await getDatabasesPath();
    final String fullPath = join(databasesPath, dbName);
    bool dbExisit = await databaseExists(fullPath);

    if (!dbExisit) {
      // Should happen only the first time the app launches
      try {
        // Make sure the parent directory exists
        await Directory(dirname(fullPath)).create(recursive: true);

        // Copy database from assets to the app's document directory
        ByteData data = await rootBundle.load(join('assets/database', dbName));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(fullPath).writeAsBytes(bytes);
      } catch (e) {
        // print('Error copying database: $e');
      }
    }
    // return openDatabase(fullPath);
    return openDatabase(fullPath);
  }

// getting all the items in the list from the database
  static Future<List<Poem>> getPoemList() async {
    final dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient.query(poemTable);
    return queryResult.map((result) => Poem.fromMap(result)).toList();
  }

  static Future<List<String>> getChaptersList() async {
    final dbClient = await database;
    final List<Map<String, Object?>> queryResult = await dbClient
        .rawQuery('Select Distinct chapter from $poemTable ORDER BY id');
    return queryResult.map((result) => result['chapter'].toString()).toList();
  }

  static Future update(
    String tableName,
    String columnName,
    String value,
    int id,
  ) async {
    final db = await DbHelper.database;

    return db.update(
      tableName,
      {columnName: value},
      where: 'id = ? ',
      whereArgs: [id],
    );
  }

  static Future insert(String table, Map<String, Object> data) async {
    final db = await DbHelper.database;
    return db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future delete(String table, int id) async {
    final db = await DbHelper.database;
    return db.delete(
      table,
      where: 'id = ? ',
      whereArgs: [id],
    );
  }

  static Future<Poem> getPoemById(int id) async {
    var db = await database;
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('Select * From $poemTable Where id=?', [id]);
    return queryResult.map((result) => Poem.fromMap(result)).first;
  }

  static Future<Poem?> getRandomSuggestedPoem() async {
    var db = await database;
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
        'Select * From $suggestedPoemsTable ORDER BY RANDOM() LIMIT 1');
    return queryResult.map((result) => Poem.fromMap(result)).firstOrNull;
  }
}

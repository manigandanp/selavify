import 'dart:async';
import 'package:path/path.dart';
import 'package:selavify/models/model.dart';
import 'package:sqflite/sqflite.dart';

abstract class DBService {
  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {
    String dbName = "selavify_db";
    String _path = join(await getDatabasesPath(), dbName);

    if (_db != null) return;
    try {
      _db = await openDatabase(_path, version: _version, onCreate: _onCreate);
    } catch (e) {
      print(e);
    }
  }

  static void _onCreate(Database db, int version) async {
    await db.execute(
        'create table selavifyTransaction (id PRIMARY KEY NOT NULL UNIQUE, transactionTitle Text, transactionAmount real, transactionTimestamp integer, createdTimestamp Integer, updatedTimestamp integer, categoryId Text, transactionTypeId Text, transactionSourceId Text)');

    await db.execute(
        'create Table transactionType (id PRIMARY key not NULL UNIQUE, transactionTypeTitle Text, createdtimestamp integer)');

    await db.execute(
        'create table category (id PRIMARY key not NULL UNIQUE, category Text, createdtimestamp integer)');

    await db.execute(
        'create table transactionSource (id PRIMARY key not NULL UNIQUE, source Text, createdtimestamp integer)');

    await db.execute(
        'INSERT into transactionType values ("0bfbce69-177c-42bc-80a3-6c594a961529", "Income", 1604126154709), ("278ee9d2-1008-408d-a34d-d180d836996c", "Expanses", 1604126359711), ("25db44bb-5e87-4de2-8c08-d7b72eea9a02", "Investment", 1604126400715), ("996419a3-ef10-4c94-9c1f-e035eb4c18ec", "Withdrawl", 1604126400715)');
  }

  static Future<List<Map<String, dynamic>>> query(String tableName) async =>
      _db.query(tableName);

  static Future<int> insert(String tableName, Model model) async =>
      await _db.insert(tableName, model.toMap());

  static Future<int> update(String tableName, Model model) async => await _db
      .update(tableName, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String tableName, Model model) async =>
      await _db.delete(tableName, where: 'id = ?', whereArgs: [model.id]);
}

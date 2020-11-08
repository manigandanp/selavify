import 'dart:async';
import 'package:path/path.dart';
import 'package:selavify/models/category.dart';
import 'package:selavify/models/model.dart';
import 'package:selavify/models/source.dart';
import 'package:selavify/models/transaction_type.dart';
import 'package:selavify/services/category_service.dart';
import 'package:selavify/services/source_service.dart';
import 'package:selavify/services/transaction_service.dart';
import 'package:selavify/services/transaction_type_service.dart';
import 'package:sqflite/sqflite.dart';

abstract class DBService {
  static Database _db;

  static int get _version => 1;

  static Future<void> init([String dbName = "selavify_db"]) async {
    // String dbName = "selavify_db";
    String _path = join(await getDatabasesPath(), dbName);
    // deleteDatabase(_path);
    print("[db_path >>] " + _path);
    if (_db != null) return;
    try {
      _db = await openDatabase(_path, version: _version, onCreate: _onCreate);
    } catch (e) {
      print(e);
    } finally {
      if (_db != null) print("db has been initiated...");
    }
  }

  static void _onCreate(Database db, int version) async {
    await db.execute(TransactionService.createTableSqlStmt);
    await db.execute(CategoryService.createTableSqlStmt);
    await db.execute(SourceService.createTableSqlStmt);
    await db.execute(TransactionTypeService.createTableSqlStmt);

    String transactionTypeValues = _toValues(TransactionTypeService.values);
    String categoryValues = _toValues(CategoryService.values);
    String sourceValues = _toValues(SourceService.values);

    await db.execute(
        'insert into ${TransactionType.tableName} values $transactionTypeValues');
    await db
        .execute('insert into ${Category.tableName} values $categoryValues');
    await db.execute('insert into ${Source.tableName} values $sourceValues');
  }

  static String _toValues(models) => models
      .map((model) =>
          '("${model.id}", "${model.title}", "${model.createdTimestamp}")')
      .toList()
      .join(", ");

  static Future<List<Map<String, dynamic>>> query(String tableName) async =>
      _db.query(tableName);

  static Future<int> insert(String tableName, Model model) async =>
      await _db.insert(tableName, model.toJson());

  static Future<int> update(String tableName, Model model) async =>
      await _db.update(tableName, model.toJson(),
          where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String tableName, Model model) async =>
      await _db.delete(tableName, where: 'id = ?', whereArgs: [model.id]);

  static Future<Map<String, dynamic>> queryDefaultValues() async {
    var categories = await query(Category.tableName);
    var transactionTypes = await query(TransactionType.tableName);
    var sources = await query(Source.tableName);
    return {
      "category": categories.map((c) => Category.fromJson(c)).toList(),
      "transactionType":
          transactionTypes.map((t) => TransactionType.fromJson(t)).toList(),
      "source": sources.map((s) => Source.fromJson(s)).toList(),
    };
  }
}

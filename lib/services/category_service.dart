import 'package:selavify/models/category.dart';
import 'package:uuid/uuid.dart';

import 'helper.dart';

class CategoryService {
  static final _tableName = Category.tableName;
  static final _defaultValues = [
    "Salary",
    "Entertainment",
    "Transport",
    "Grocery",
  ];
  static final List<Category> values = Helper.toInsertValues(_defaultValues)
      .map((json) => Category.fromJson(json))
      .toList();

  static final createTableSqlStmt = '''
  CREATE TABLE IF NOT EXISTS $_tableName (
    id PRIMARY key not NULL UNIQUE, 
    title Text, 
    createdTimestamp integer)
  ''';
}

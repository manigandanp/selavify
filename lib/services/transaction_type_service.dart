import 'package:selavify/models/transaction_type.dart';

import 'helper.dart';

class TransactionTypeService {
  static final tableName = TransactionType.tableName;

  static final _defaultValues = [
    "Income",
    "Expanses",
    "Investments",
    "Withdrawl"
  ];

  static final List<TransactionType> values =
      Helper.toInsertValues(_defaultValues).map((json) => TransactionType.fromJson(json))
      .toList();

  static final createTableSqlStmt = '''
  CREATE TABLE IF NOT EXISTS $tableName (
    id PRIMARY key not NULL UNIQUE, 
    title Text, 
    createdTimestamp integer)
  ''';
}

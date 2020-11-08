import 'package:selavify/models/transaction.dart';
import 'package:selavify/services/db_service.dart';
import 'package:uuid/uuid.dart';

class TransactionService {
  static final _tableName = Transaction.tableName;

  static final createTableSqlStmt = '''CREATE TABLE IF NOT EXISTS $_tableName (
        id PRIMARY KEY NOT NULL UNIQUE, 
        transactionTitle Text, 
        transactionAmount real, 
        transactionTimestamp integer, 
        createdTimestamp Integer, 
        updatedTimestamp integer, 
        categoryId Text, 
        transactionTypeId Text, 
        transactionSourceId Text)''';

  static Future<List<Transaction>> fetchTransactions() async {
    List<Map<String, dynamic>> _results =
        await DBService.query(_tableName);
    return _results.map((tr) => Transaction.fromJson(tr)).toList();
  }

  static Future<Map<String, dynamic>> addTransaction(tr) async {
    final transaction = {
      "id": new Uuid().v4(),
      "createdTimestamp": DateTime.now().millisecondsSinceEpoch,
      "updatedTimestap": DateTime.now().millisecondsSinceEpoch,
      ...tr
    };

    int response = await DBService.insert(
        _tableName, Transaction.fromJson({...transaction}));
    return response > 0 ? {...transaction} : null;
  }
}

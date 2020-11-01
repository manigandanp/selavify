import 'package:selavify/models/transaction.dart';
import 'package:selavify/services/db_service.dart';
import 'package:uuid/uuid.dart';

class TransactionService {
  static Future<List<Transaction>> fetchTransactions() async {
    List<Map<String, dynamic>> _results =
        await DBService.query(Transaction.tableName);
    return _results.map((tr) => Transaction.fromJson(tr)).toList();
  }

  static Future<int> addTransaction(tr) async {
    final metaData = {
      "id": new Uuid().v4(),
      "createdTimestamp": DateTime.now().millisecondsSinceEpoch,
      "updatedTimestap": DateTime.now().millisecondsSinceEpoch,
    };
    return await DBService.insert(
        Transaction.tableName, Transaction.fromJson({...tr, ...metaData}));
  }
}

import 'package:selavify/models/transaction.dart';
import 'package:selavify/services/db_service.dart';

class TransactionService {
  Future<List<Transaction>> fetchTransactions() async {
    List<Map<String, dynamic>> _results =
        await DBService.query(Transaction.tableName);
    return _results.map((tr) => Transaction.fromJson(tr)).toList();
  }
}

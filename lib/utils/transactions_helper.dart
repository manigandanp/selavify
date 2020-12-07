import 'package:selavify/models/app_database.dart';
import 'package:selavify/models/dao.dart';

class TransactionsHelper {
  final TransactionDao transactionDao;

  TransactionsHelper(this.transactionDao);

  void createTransaction(Map<String, dynamic> json) {
    transactionDao.createTransaction(
      json['transactionTitle'],
      json['amount'],
      json["category"],
      json["source"],
      json["transaction_type"],
      transactionTimestamp: json["transactionTimestamp"],
    );
  }

  void updateTransaction(
      TransactionEntry oldTransaction, Map<String, dynamic> json) {
    transactionDao.updateTransaction(
      oldTransaction.copyWith(
          title: json['transactionTitle'],
          amount: json['amount'],
          categoryId: json["category"],
          sourceId: json["source"],
          transactionTypeId: json["transaction_type"],
          transactionTimestamp: json["transactionTimestamp"]),
    );
  }
}

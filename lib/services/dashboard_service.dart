import 'package:selavify/models/dao.dart';
import 'package:selavify/models/models.dart';
import 'package:selavify/models/summary_model.dart';
import 'package:selavify/extensions/transactions_extension.dart';

class DashboardService {
  final TransactionDao dao;

  DashboardService(this.dao);

  Stream<List<Summary>> watchSummary() {
    Stream<List<TransactionWithCategorySourceAndTType>> tr =
        dao.watchTransactions();

    return tr.map((rows) => [Summary.fromJson(rows.summary)]);
    // return tr.map((rows) => Summary.fromJson(rows.summary));
  }

  Future<List<String>> getTransactionsAsCsv({withHeader = false}) async {
    List<TransactionWithCategorySourceAndTType> tr =
        await dao.getTransactions();
    return tr.toCsv(withHeader: withHeader);
  }
}

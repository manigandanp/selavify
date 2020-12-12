import 'package:selavify/pages/add_transaction.dart';
import 'package:selavify/pages/categories.dart';
import 'package:selavify/pages/dashboard_page.dart';
import 'package:selavify/pages/sources.dart';
import 'package:selavify/pages/transaction_type.dart';
import 'package:selavify/pages/transactions.dart';

final routes = {
  CategoryList.routeName: (context) => CategoryList(),
  SourceList.routeName: (context) => SourceList(),
  TransactionTypeList.routeName: (context) => TransactionTypeList(),
  TransactionsList.routeName: (context) => TransactionsList(),
  AddNewTransaction.routeName: (context) => AddNewTransaction(),
  Dashboard.routeName: (context) => Dashboard(),
};

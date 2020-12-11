import 'package:selavify/models/app_database.dart';
import 'package:selavify/models/models.dart';

final date = DateTime.parse("2021-01-01 00:00:00.000").millisecondsSinceEpoch;

List categories = [
  Category(id: "c1", title: "cat 1", createdDate: date),
  Category(id: "c2", title: "cat 2", createdDate: date),
  Category(id: "c3", title: "cat 3", createdDate: date),
  Category(id: "c4", title: "cat 4", createdDate: date),
  Category(id: "c5", title: "cat 5", createdDate: date),
];

List sources = [
  Source(id: "s1", title: "Account", createdDate: date),
  Source(id: "s2", title: "Cash", createdDate: date),
];

List tTypes = [
  TransactionType(id: "t1", title: "Income", createdDate: date),
  TransactionType(id: "t2", title: "Expanse", createdDate: date),
  TransactionType(id: "t3", title: "Investment", createdDate: date),
  TransactionType(id: "t4", title: "Withdrawl", createdDate: date),
];

List transactions = [
  TransactionEntry(
      id: "t0",
      title: "tr 0",
      amount: 1000.0,
      categoryId: "c1",
      sourceId: "s1",
      transactionTypeId: "t1",
      transactionTimestamp: date),
  TransactionEntry(
      id: "t1",
      title: "tr 1",
      amount: 500.0,
      categoryId: "c1",
      sourceId: "s2",
      transactionTypeId: "t1",
      transactionTimestamp: date),
  TransactionEntry(
      id: "t2",
      title: "tr 2",
      amount: 200.0,
      categoryId: "c2",
      sourceId: "s1",
      transactionTypeId: "t4",
      transactionTimestamp: date),
  TransactionEntry(
      id: "t3",
      title: "tr 3",
      amount: 300.0,
      categoryId: "c3",
      sourceId: "s1",
      transactionTypeId: "t2",
      transactionTimestamp: date),
  TransactionEntry(
      id: "t4",
      title: "tr 4",
      amount: 100.0,
      categoryId: "c4",
      sourceId: "s2",
      transactionTypeId: "t3",
      transactionTimestamp: date),
  TransactionEntry(
      id: "t5",
      title: "tr 5",
      amount: 50.0,
      categoryId: "c4",
      sourceId: "s2",
      transactionTypeId: "t2",
      transactionTimestamp: date),
];

/*
  income = 1500 (cash: 500, acc: 1000)
  expanse = 350 ( acc: 300 , cash : 50)
  invst = 100
  withdrawl = 200 (now income become (cash: 700 and acc: 800))
*/

List<TransactionWithCategorySourceAndTType> joinedTables = [
  TransactionWithCategorySourceAndTType(
    transactions: transactions[0],
    sources: sources[0],
    categories: categories[0],
    transactionTypes: tTypes[0],
  ),
  TransactionWithCategorySourceAndTType(
    transactions: transactions[1],
    sources: sources[1],
    categories: categories[0],
    transactionTypes: tTypes[0],
  ),
  TransactionWithCategorySourceAndTType(
    transactions: transactions[2],
    sources: sources[0],
    categories: categories[1],
    transactionTypes: tTypes[3],
  ),
  TransactionWithCategorySourceAndTType(
    transactions: transactions[3],
    sources: sources[0],
    categories: categories[2],
    transactionTypes: tTypes[1],
  ),
  TransactionWithCategorySourceAndTType(
    transactions: transactions[4],
    sources: sources[1],
    categories: categories[3],
    transactionTypes: tTypes[2],
  ),
  TransactionWithCategorySourceAndTType(
    transactions: transactions[5],
    sources: sources[1],
    categories: categories[3],
    transactionTypes: tTypes[1],
  ),
];

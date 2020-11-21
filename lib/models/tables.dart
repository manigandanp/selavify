import 'dart:convert';

import 'package:moor/moor.dart';
import 'package:selavify/models/app_database.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

@DataClassName('NewTransaction')
class Transactions extends Table {
  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get title => text().withLength(min: 1)();
  RealColumn get amount => real()();
  TextColumn get categoryId =>
      text().customConstraint("REFERENCES categories(id)")();
  TextColumn get sourceId =>
      text().customConstraint("REFERENCES sources(id)")();
  // moor converts camlecase table name to _ name while creating actual tables in db: transactionTypes becomes transaction_types
  TextColumn get transactionTypeId =>
      text().customConstraint("REFERENCES transaction_types(id)")();

  IntColumn get transactionTimestamp =>
      integer().withDefault(currentDateAndTime.secondsSinceEpoch)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Category')
class Categories extends Table {
  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get title => text().withLength(min: 1)();
  IntColumn get createdDate =>
      integer().withDefault(currentDateAndTime.secondsSinceEpoch)();

  @override
  Set<Column> get primaryKey => {id};
}

class Sources extends Table {
  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get title => text().withLength(min: 1)();
  IntColumn get createdDate =>
      integer().withDefault(currentDateAndTime.secondsSinceEpoch)();

  @override
  Set<Column> get primaryKey => {id};
}

class TransactionTypes extends Table {
  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get title => text().withLength(min: 1)();
  IntColumn get createdDate =>
      integer().withDefault(currentDateAndTime.secondsSinceEpoch)();

  @override
  Set<Column> get primaryKey => {id};
}

class TransactionData {
  final NewTransaction transactions; // this is dataclass not tables
  final Category categories;
  final Source sources;
  final TransactionType transactionTypes;

  TransactionData({
    @required this.transactions,
    @required this.sources,
    @required this.categories,
    @required this.transactionTypes,
  });

  @override
  String toString() {
    return jsonEncode({
      'transactions': transactions.toString(),
      'sooures': sources.toString(),
      'categories': categories.toString(),
      'transactionType': transactionTypes.toString()
    });
  }
}

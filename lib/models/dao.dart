import 'package:moor/moor.dart';
import 'package:selavify/models/app_database.dart';
import 'package:selavify/models/tables.dart';

part 'dao.g.dart';

@UseDao(tables: [Transactions, Sources, Categories, TransactionTypes])
class TransactionDao extends DatabaseAccessor<SelavifyDB>
    with _$TransactionDaoMixin {
  final SelavifyDB db;
  TransactionDao(this.db) : super(db);

  Future<int> createTransaction(String title, double amount, String categoryId,
      String sourceId, String tTypeId,
      {int transactionTimestamp}) {
    return into(transactions).insert(TransactionsCompanion(
      title: Value(title),
      amount: Value(amount),
      categoryId: Value(categoryId),
      sourceId: Value(sourceId),
      transactionTypeId: Value(tTypeId),
      transactionTimestamp: transactionTimestamp == null
          ? Value.absent()
          : Value(transactionTimestamp),
    ));
  }

  Future<List<NewTransaction>> getTransactions() {
    return select(transactions).get();
  }

  JoinedSelectStatement<$TransactionsTable, NewTransaction> _joinTransaction(
      {SimpleSelectStatement<$TransactionsTable, NewTransaction>
          selectStatment}) {
    return (selectStatment == null ? select(transactions) : selectStatment
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.transactionTimestamp, mode: OrderingMode.desc)
          ]))
        .join([
      innerJoin(sources, sources.id.equalsExp(transactions.sourceId)),
      innerJoin(categories, categories.id.equalsExp(transactions.categoryId)),
      innerJoin(transactionTypes,
          transactionTypes.id.equalsExp(transactions.transactionTypeId)),
    ]);
  }

  Stream<List<TransactionData>> watchTransactions() {
    return _joinTransaction().watch().map(
          (rows) => rows.map((row) {
            return TransactionData(
                transactions: row.readTable(transactions),
                categories: row.readTable(categories),
                transactionTypes: row.readTable(transactionTypes),
                sources: row.readTable(sources));
          }).toList(),
        );
  }

  Stream<List<TransactionData>> watchAndFilterTransactionsByTime(
      {@required int fromTimestamp, int toTimestamp}) {
    SimpleSelectStatement<$TransactionsTable, NewTransaction> selectStatement =
        toTimestamp == null
            ? (select(transactions)
              ..where((tbl) =>
                  tbl.transactionTimestamp.isBiggerOrEqualValue(fromTimestamp)))
            : (select(transactions)
              ..where((tbl) => tbl.transactionTimestamp
                  .isBetweenValues(fromTimestamp, toTimestamp)));
    return _joinTransaction(selectStatment: selectStatement).watch().map(
          (rows) => rows.map((row) {
            return TransactionData(
                transactions: row.readTable(transactions),
                categories: row.readTable(categories),
                transactionTypes: row.readTable(transactionTypes),
                sources: row.readTable(sources));
          }).toList(),
        );
  }

  Future<void> updateTransaction(NewTransaction transaction) {
    return update(transactions).replace(transaction);
  }

  Future<void> deleteTransaction(String id) {
    return (delete(transactions)..where((t) => t.id.equals(id))).go();
  }
}

@UseDao(tables: [Categories])
class CategoryDao extends DatabaseAccessor<SelavifyDB> with _$CategoryDaoMixin {
  final SelavifyDB db;
  CategoryDao(this.db) : super(db);

  Future createCategory(String title) {
    return into(categories).insert(CategoriesCompanion(title: Value(title)));
  }

  Future<List<Category>> getAllCategories() {
    return select(categories).get();
  }

  Stream<List<Category>> watchCategories() {
    return select(categories).watch();
  }

  Future updateCategory(Category category) {
    return update(categories).replace(category);
  }

  Future deleteCategory(String id) {
    return (delete(categories)..where((c) => c.id.equals(id))).go();
  }
}

@UseDao(tables: [Sources])
class SourceDao extends DatabaseAccessor<SelavifyDB> with _$SourceDaoMixin {
  final SelavifyDB db;
  SourceDao(this.db) : super(db);

  Future createSource(String title) {
    return into(sources).insert(SourcesCompanion(title: Value(title)));
  }

  Future<List<Source>> getAllSources() {
    return select(sources).get();
  }

  Stream<List<Source>> watchSources() {
    return select(sources).watch();
  }

  Future updateSource(Source source) {
    return update(sources).replace(source);
  }

  Future deleteSource(String id) {
    return (delete(sources)..where((s) => s.id.equals(id))).go();
  }
}

@UseDao(tables: [TransactionTypes])
class TransactionTypeDao extends DatabaseAccessor<SelavifyDB>
    with _$TransactionTypeDaoMixin {
  final SelavifyDB db;
  TransactionTypeDao(this.db) : super(db);

  Future createTransactionType(String title) {
    return into(transactionTypes)
        .insert(TransactionTypesCompanion(title: Value(title)));
  }

  Future<List<TransactionType>> getAllTransactionTypes() {
    return select(transactionTypes).get();
  }

  Stream<List<TransactionType>> watchTransactionTypes() {
    return select(transactionTypes).watch();
  }

  Future updateTransactionType(TransactionType tType) {
    return update(transactionTypes).replace(tType);
  }

  Future deleteTransactionType(String id) {
    return (delete(transactionTypes)..where((t) => t.id.equals(id))).go();
  }
}

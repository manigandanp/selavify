// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dao.dart';

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TransactionDaoMixin on DatabaseAccessor<SelavifyDB> {
  $TransactionsTable get transactions => attachedDatabase.transactions;
  $SourcesTable get sources => attachedDatabase.sources;
  $CategoriesTable get categories => attachedDatabase.categories;
  $TransactionTypesTable get transactionTypes =>
      attachedDatabase.transactionTypes;
}
mixin _$CategoryDaoMixin on DatabaseAccessor<SelavifyDB> {
  $CategoriesTable get categories => attachedDatabase.categories;
}
mixin _$SourceDaoMixin on DatabaseAccessor<SelavifyDB> {
  $SourcesTable get sources => attachedDatabase.sources;
}
mixin _$TransactionTypeDaoMixin on DatabaseAccessor<SelavifyDB> {
  $TransactionTypesTable get transactionTypes =>
      attachedDatabase.transactionTypes;
}

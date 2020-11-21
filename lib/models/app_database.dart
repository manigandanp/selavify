import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:selavify/models/dao.dart';
import 'dart:io';

import 'package:selavify/models/tables.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

// moor_generator is not importing Uuid package. this is a workaround to avoid errors.
final _uuid = Uuid();

LazyDatabase _openConnection({dbName}) {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, dbName ?? 'db.sqlite'));
      return VmDatabase(file, logStatements: true);
    },
  );
}

@UseMoor(
    tables: [Transactions, Categories, Sources, TransactionTypes],
    daos: [TransactionDao, CategoryDao, SourceDao, TransactionTypeDao])
class SelavifyDB extends _$SelavifyDB {
  SelavifyDB() : super(_openConnection());
  SelavifyDB.withName(dbName) : super(_openConnection(dbName: dbName));
  SelavifyDB.testConstructor(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

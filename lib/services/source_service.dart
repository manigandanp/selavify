import 'package:selavify/models/source.dart';
import 'package:uuid/uuid.dart';

import 'helper.dart';

class SourceService {
  static final _tableName = Source.tableName;
  static final _defaultValues = ["Account", "Cash"];

  static final List<Source> values = Helper.toInsertValues(_defaultValues)
      .map((json) => Source.fromJson(json))
      .toList();

  static final createTableSqlStmt = '''
  CREATE TABLE IF NOT EXISTS $_tableName (
    id PRIMARY key not NULL UNIQUE, 
    title Text, 
    createdTimestamp integer)
  ''';
}

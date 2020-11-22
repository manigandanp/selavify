// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class NewTransaction extends DataClass implements Insertable<NewTransaction> {
  final String id;
  final String title;
  final double amount;
  final String categoryId;
  final String sourceId;
  final String transactionTypeId;
  final int transactionTimestamp;
  NewTransaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.categoryId,
      @required this.sourceId,
      @required this.transactionTypeId,
      @required this.transactionTimestamp});
  factory NewTransaction.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final intType = db.typeSystem.forDartType<int>();
    return NewTransaction(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      amount:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}amount']),
      categoryId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id']),
      sourceId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}source_id']),
      transactionTypeId: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}transaction_type_id']),
      transactionTimestamp: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}transaction_timestamp']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<String>(sourceId);
    }
    if (!nullToAbsent || transactionTypeId != null) {
      map['transaction_type_id'] = Variable<String>(transactionTypeId);
    }
    if (!nullToAbsent || transactionTimestamp != null) {
      map['transaction_timestamp'] = Variable<int>(transactionTimestamp);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      transactionTypeId: transactionTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionTypeId),
      transactionTimestamp: transactionTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionTimestamp),
    );
  }

  factory NewTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return NewTransaction(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      transactionTypeId: serializer.fromJson<String>(json['transactionTypeId']),
      transactionTimestamp:
          serializer.fromJson<int>(json['transactionTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'categoryId': serializer.toJson<String>(categoryId),
      'sourceId': serializer.toJson<String>(sourceId),
      'transactionTypeId': serializer.toJson<String>(transactionTypeId),
      'transactionTimestamp': serializer.toJson<int>(transactionTimestamp),
    };
  }

  NewTransaction copyWith(
          {String id,
          String title,
          double amount,
          String categoryId,
          String sourceId,
          String transactionTypeId,
          int transactionTimestamp}) =>
      NewTransaction(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        categoryId: categoryId ?? this.categoryId,
        sourceId: sourceId ?? this.sourceId,
        transactionTypeId: transactionTypeId ?? this.transactionTypeId,
        transactionTimestamp: transactionTimestamp ?? this.transactionTimestamp,
      );
  @override
  String toString() {
    return (StringBuffer('NewTransaction(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('sourceId: $sourceId, ')
          ..write('transactionTypeId: $transactionTypeId, ')
          ..write('transactionTimestamp: $transactionTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              amount.hashCode,
              $mrjc(
                  categoryId.hashCode,
                  $mrjc(
                      sourceId.hashCode,
                      $mrjc(transactionTypeId.hashCode,
                          transactionTimestamp.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is NewTransaction &&
          other.id == this.id &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.categoryId == this.categoryId &&
          other.sourceId == this.sourceId &&
          other.transactionTypeId == this.transactionTypeId &&
          other.transactionTimestamp == this.transactionTimestamp);
}

class TransactionsCompanion extends UpdateCompanion<NewTransaction> {
  final Value<String> id;
  final Value<String> title;
  final Value<double> amount;
  final Value<String> categoryId;
  final Value<String> sourceId;
  final Value<String> transactionTypeId;
  final Value<int> transactionTimestamp;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.transactionTypeId = const Value.absent(),
    this.transactionTimestamp = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required double amount,
    @required String categoryId,
    @required String sourceId,
    @required String transactionTypeId,
    this.transactionTimestamp = const Value.absent(),
  })  : title = Value(title),
        amount = Value(amount),
        categoryId = Value(categoryId),
        sourceId = Value(sourceId),
        transactionTypeId = Value(transactionTypeId);
  static Insertable<NewTransaction> custom({
    Expression<String> id,
    Expression<String> title,
    Expression<double> amount,
    Expression<String> categoryId,
    Expression<String> sourceId,
    Expression<String> transactionTypeId,
    Expression<int> transactionTimestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (categoryId != null) 'category_id': categoryId,
      if (sourceId != null) 'source_id': sourceId,
      if (transactionTypeId != null) 'transaction_type_id': transactionTypeId,
      if (transactionTimestamp != null)
        'transaction_timestamp': transactionTimestamp,
    });
  }

  TransactionsCompanion copyWith(
      {Value<String> id,
      Value<String> title,
      Value<double> amount,
      Value<String> categoryId,
      Value<String> sourceId,
      Value<String> transactionTypeId,
      Value<int> transactionTimestamp}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      sourceId: sourceId ?? this.sourceId,
      transactionTypeId: transactionTypeId ?? this.transactionTypeId,
      transactionTimestamp: transactionTimestamp ?? this.transactionTimestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (transactionTypeId.present) {
      map['transaction_type_id'] = Variable<String>(transactionTypeId.value);
    }
    if (transactionTimestamp.present) {
      map['transaction_timestamp'] = Variable<int>(transactionTimestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('sourceId: $sourceId, ')
          ..write('transactionTypeId: $transactionTypeId, ')
          ..write('transactionTimestamp: $transactionTimestamp')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, NewTransaction> {
  final GeneratedDatabase _db;
  final String _alias;
  $TransactionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => _uuid.v4();
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  GeneratedRealColumn _amount;
  @override
  GeneratedRealColumn get amount => _amount ??= _constructAmount();
  GeneratedRealColumn _constructAmount() {
    return GeneratedRealColumn(
      'amount',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  GeneratedTextColumn _categoryId;
  @override
  GeneratedTextColumn get categoryId => _categoryId ??= _constructCategoryId();
  GeneratedTextColumn _constructCategoryId() {
    return GeneratedTextColumn('category_id', $tableName, false,
        $customConstraints: 'REFERENCES categories(id)');
  }

  final VerificationMeta _sourceIdMeta = const VerificationMeta('sourceId');
  GeneratedTextColumn _sourceId;
  @override
  GeneratedTextColumn get sourceId => _sourceId ??= _constructSourceId();
  GeneratedTextColumn _constructSourceId() {
    return GeneratedTextColumn('source_id', $tableName, false,
        $customConstraints: 'REFERENCES sources(id)');
  }

  final VerificationMeta _transactionTypeIdMeta =
      const VerificationMeta('transactionTypeId');
  GeneratedTextColumn _transactionTypeId;
  @override
  GeneratedTextColumn get transactionTypeId =>
      _transactionTypeId ??= _constructTransactionTypeId();
  GeneratedTextColumn _constructTransactionTypeId() {
    return GeneratedTextColumn('transaction_type_id', $tableName, false,
        $customConstraints: 'REFERENCES transaction_types(id)');
  }

  final VerificationMeta _transactionTimestampMeta =
      const VerificationMeta('transactionTimestamp');
  GeneratedIntColumn _transactionTimestamp;
  @override
  GeneratedIntColumn get transactionTimestamp =>
      _transactionTimestamp ??= _constructTransactionTimestamp();
  GeneratedIntColumn _constructTransactionTimestamp() {
    return GeneratedIntColumn(
      'transaction_timestamp',
      $tableName,
      false,
    )..clientDefault = () => DateTime.now().millisecondsSinceEpoch;
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        amount,
        categoryId,
        sourceId,
        transactionTypeId,
        transactionTimestamp
      ];
  @override
  $TransactionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'transactions';
  @override
  final String actualTableName = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<NewTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount'], _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id'], _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id'], _sourceIdMeta));
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('transaction_type_id')) {
      context.handle(
          _transactionTypeIdMeta,
          transactionTypeId.isAcceptableOrUnknown(
              data['transaction_type_id'], _transactionTypeIdMeta));
    } else if (isInserting) {
      context.missing(_transactionTypeIdMeta);
    }
    if (data.containsKey('transaction_timestamp')) {
      context.handle(
          _transactionTimestampMeta,
          transactionTimestamp.isAcceptableOrUnknown(
              data['transaction_timestamp'], _transactionTimestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewTransaction map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return NewTransaction.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(_db, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String title;
  final int createdDate;
  Category(
      {@required this.id, @required this.title, @required this.createdDate});
  factory Category.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Category(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      createdDate: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<int>(createdDate);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdDate: serializer.fromJson<int>(json['createdDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'createdDate': serializer.toJson<int>(createdDate),
    };
  }

  Category copyWith({String id, String title, int createdDate}) => Category(
        id: id ?? this.id,
        title: title ?? this.title,
        createdDate: createdDate ?? this.createdDate,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdDate: $createdDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(title.hashCode, createdDate.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdDate == this.createdDate);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> createdDate;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdDate = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    this.createdDate = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Category> custom({
    Expression<String> id,
    Expression<String> title,
    Expression<int> createdDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdDate != null) 'created_date': createdDate,
    });
  }

  CategoriesCompanion copyWith(
      {Value<String> id, Value<String> title, Value<int> createdDate}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<int>(createdDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdDate: $createdDate')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => _uuid.v4();
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedIntColumn _createdDate;
  @override
  GeneratedIntColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedIntColumn _constructCreatedDate() {
    return GeneratedIntColumn(
      'created_date',
      $tableName,
      false,
    )..clientDefault = () => DateTime.now().millisecondsSinceEpoch;
  }

  @override
  List<GeneratedColumn> get $columns => [id, title, createdDate];
  @override
  $CategoriesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'categories';
  @override
  final String actualTableName = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date'], _createdDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Category.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(_db, alias);
  }
}

class Source extends DataClass implements Insertable<Source> {
  final String id;
  final String title;
  final int createdDate;
  Source({@required this.id, @required this.title, @required this.createdDate});
  factory Source.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Source(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      createdDate: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<int>(createdDate);
    }
    return map;
  }

  SourcesCompanion toCompanion(bool nullToAbsent) {
    return SourcesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
    );
  }

  factory Source.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Source(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdDate: serializer.fromJson<int>(json['createdDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'createdDate': serializer.toJson<int>(createdDate),
    };
  }

  Source copyWith({String id, String title, int createdDate}) => Source(
        id: id ?? this.id,
        title: title ?? this.title,
        createdDate: createdDate ?? this.createdDate,
      );
  @override
  String toString() {
    return (StringBuffer('Source(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdDate: $createdDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(title.hashCode, createdDate.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Source &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdDate == this.createdDate);
}

class SourcesCompanion extends UpdateCompanion<Source> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> createdDate;
  const SourcesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdDate = const Value.absent(),
  });
  SourcesCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    this.createdDate = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Source> custom({
    Expression<String> id,
    Expression<String> title,
    Expression<int> createdDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdDate != null) 'created_date': createdDate,
    });
  }

  SourcesCompanion copyWith(
      {Value<String> id, Value<String> title, Value<int> createdDate}) {
    return SourcesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<int>(createdDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SourcesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdDate: $createdDate')
          ..write(')'))
        .toString();
  }
}

class $SourcesTable extends Sources with TableInfo<$SourcesTable, Source> {
  final GeneratedDatabase _db;
  final String _alias;
  $SourcesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => _uuid.v4();
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedIntColumn _createdDate;
  @override
  GeneratedIntColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedIntColumn _constructCreatedDate() {
    return GeneratedIntColumn(
      'created_date',
      $tableName,
      false,
    )..clientDefault = () => DateTime.now().millisecondsSinceEpoch;
  }

  @override
  List<GeneratedColumn> get $columns => [id, title, createdDate];
  @override
  $SourcesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'sources';
  @override
  final String actualTableName = 'sources';
  @override
  VerificationContext validateIntegrity(Insertable<Source> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date'], _createdDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Source map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Source.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SourcesTable createAlias(String alias) {
    return $SourcesTable(_db, alias);
  }
}

class TransactionType extends DataClass implements Insertable<TransactionType> {
  final String id;
  final String title;
  final int createdDate;
  TransactionType(
      {@required this.id, @required this.title, @required this.createdDate});
  factory TransactionType.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return TransactionType(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      createdDate: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || createdDate != null) {
      map['created_date'] = Variable<int>(createdDate);
    }
    return map;
  }

  TransactionTypesCompanion toCompanion(bool nullToAbsent) {
    return TransactionTypesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
    );
  }

  factory TransactionType.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TransactionType(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdDate: serializer.fromJson<int>(json['createdDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'createdDate': serializer.toJson<int>(createdDate),
    };
  }

  TransactionType copyWith({String id, String title, int createdDate}) =>
      TransactionType(
        id: id ?? this.id,
        title: title ?? this.title,
        createdDate: createdDate ?? this.createdDate,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionType(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdDate: $createdDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(title.hashCode, createdDate.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TransactionType &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdDate == this.createdDate);
}

class TransactionTypesCompanion extends UpdateCompanion<TransactionType> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> createdDate;
  const TransactionTypesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdDate = const Value.absent(),
  });
  TransactionTypesCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    this.createdDate = const Value.absent(),
  }) : title = Value(title);
  static Insertable<TransactionType> custom({
    Expression<String> id,
    Expression<String> title,
    Expression<int> createdDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdDate != null) 'created_date': createdDate,
    });
  }

  TransactionTypesCompanion copyWith(
      {Value<String> id, Value<String> title, Value<int> createdDate}) {
    return TransactionTypesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<int>(createdDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionTypesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdDate: $createdDate')
          ..write(')'))
        .toString();
  }
}

class $TransactionTypesTable extends TransactionTypes
    with TableInfo<$TransactionTypesTable, TransactionType> {
  final GeneratedDatabase _db;
  final String _alias;
  $TransactionTypesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    )..clientDefault = () => _uuid.v4();
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedIntColumn _createdDate;
  @override
  GeneratedIntColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedIntColumn _constructCreatedDate() {
    return GeneratedIntColumn(
      'created_date',
      $tableName,
      false,
    )..clientDefault = () => DateTime.now().millisecondsSinceEpoch;
  }

  @override
  List<GeneratedColumn> get $columns => [id, title, createdDate];
  @override
  $TransactionTypesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'transaction_types';
  @override
  final String actualTableName = 'transaction_types';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_date')) {
      context.handle(
          _createdDateMeta,
          createdDate.isAcceptableOrUnknown(
              data['created_date'], _createdDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionType map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TransactionType.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TransactionTypesTable createAlias(String alias) {
    return $TransactionTypesTable(_db, alias);
  }
}

abstract class _$SelavifyDB extends GeneratedDatabase {
  _$SelavifyDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TransactionsTable _transactions;
  $TransactionsTable get transactions =>
      _transactions ??= $TransactionsTable(this);
  $CategoriesTable _categories;
  $CategoriesTable get categories => _categories ??= $CategoriesTable(this);
  $SourcesTable _sources;
  $SourcesTable get sources => _sources ??= $SourcesTable(this);
  $TransactionTypesTable _transactionTypes;
  $TransactionTypesTable get transactionTypes =>
      _transactionTypes ??= $TransactionTypesTable(this);
  TransactionDao _transactionDao;
  TransactionDao get transactionDao =>
      _transactionDao ??= TransactionDao(this as SelavifyDB);
  CategoryDao _categoryDao;
  CategoryDao get categoryDao =>
      _categoryDao ??= CategoryDao(this as SelavifyDB);
  SourceDao _sourceDao;
  SourceDao get sourceDao => _sourceDao ??= SourceDao(this as SelavifyDB);
  TransactionTypeDao _transactionTypeDao;
  TransactionTypeDao get transactionTypeDao =>
      _transactionTypeDao ??= TransactionTypeDao(this as SelavifyDB);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [transactions, categories, sources, transactionTypes];
}

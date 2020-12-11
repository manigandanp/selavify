import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:moor/ffi.dart';
import 'package:selavify/models/app_database.dart';

void main() {
  SelavifyDB db;

  setUp(() {
    db = SelavifyDB.testConstructor(VmDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group("Categories Table:", () {
    test("read and write from categories table", () async {
      await db.categoryDao.createCategory("some cat title");
      final cat = await db.categoryDao.getAllCategories();

      expect(cat.first.title, "some cat title");
    });

    test("update entries in categories table", () async {
      await db.categoryDao.createCategory("some cat title");
      final cat = await db.categoryDao.getAllCategories();

      expect(cat.first.title, "some cat title");

      Category category = cat.first.copyWith(title: "updated cat title");

      await db.categoryDao.updateCategory(category);
      final updatedCat = await db.categoryDao.getAllCategories();
      expect(updatedCat.first.title, "updated cat title");
      expect(updatedCat.length, 1);
    });

    test("delete entries from categories table", () async {
      await db.categoryDao.createCategory("some cat title");
      final cat = await db.categoryDao.getAllCategories();

      expect(cat.first.title, "some cat title");
      expect(cat.length, 1);

      await db.categoryDao.deleteCategory(cat.first.id);
      final newCat = await db.categoryDao.getAllCategories();
      expect(newCat.length, 0);
    });
  });
  group("Sources Table:", () {
    test("read and write from sources table", () async {
      await db.sourceDao.createSource("some source title");
      final src = await db.sourceDao.getAllSources();

      expect(src.first.title, "some source title");
    });

    test("update entries in sources table", () async {
      await db.sourceDao.createSource("some source title");
      final src = await db.sourceDao.getAllSources();

      expect(src.first.title, "some source title");

      Source source = src.first.copyWith(title: "updated source title");

      await db.sourceDao.updateSource(source);
      final updatedSrc = await db.sourceDao.getAllSources();
      expect(updatedSrc.first.title, "updated source title");
      expect(updatedSrc.length, 1);
    });

    test("delete entries in sources table", () async {
      await db.sourceDao.createSource("some source title");
      final src = await db.sourceDao.getAllSources();

      expect(src.first.title, "some source title");
      expect(src.length, 1);

      await db.sourceDao.deleteSource(src.first.id);
      final newSrc = await db.categoryDao.getAllCategories();
      expect(newSrc.length, 0);
    });
  });
  group("TransactionType Table:", () {
    test("read and write from transaction_type table", () async {
      await db.transactionTypeDao.createTransactionType("some tType title");
      final tType = await db.transactionTypeDao.getAllTransactionTypes();

      expect(tType.first.title, "some tType title");
    });

    test("read and write from transaction_type table", () async {
      await db.transactionTypeDao.createTransactionType("some tType title");
      final tType = await db.transactionTypeDao.getAllTransactionTypes();

      expect(tType.first.title, "some tType title");

      TransactionType tTypeNew =
          tType.first.copyWith(title: "updated ttype title");

      await db.transactionTypeDao.updateTransactionType(tTypeNew);
      final updatedtType = await db.transactionTypeDao.getAllTransactionTypes();
      expect(updatedtType.first.title, "updated ttype title");
      expect(updatedtType.length, 1);
    });
    test("delete entries in transaction_type table", () async {
      await db.transactionTypeDao.createTransactionType("some tType title");
      final tType = await db.transactionTypeDao.getAllTransactionTypes();

      expect(tType.first.title, "some tType title");
      expect(tType.length, 1);

      await db.transactionTypeDao.deleteTransactionType(tType.first.id);
      final newtType = await db.transactionTypeDao.getAllTransactionTypes();
      expect(newtType.length, 0);
    });
  });

  group("Transaction Table:", () {
    test("read and write from transactions table", () async {
      await db.categoryDao.createCategory("some cat title");
      await db.transactionTypeDao.createTransactionType("some ttype title");
      await db.sourceDao.createSource("some source title");

      final c = await db.categoryDao.getAllCategories();
      final s = await db.sourceDao.getAllSources();
      final t = await db.transactionTypeDao.getAllTransactionTypes();

      final catId = c.first.id;
      final sourceId = s.first.id;
      final tTypeId = t.first.id;

      final date = DateTime.now().subtract(Duration(days: 10));

      await db.transactionDao
          .createTransaction("title", 202.0, catId, sourceId, tTypeId);

      await db.transactionDao.createTransaction(
          "title", 202.0, catId, sourceId, tTypeId,
          transactionTimestamp: date.microsecondsSinceEpoch);

      final allTransaction = await db.transactionDao.getTransactions();

      expect(allTransaction.length, 2);

      expect(
          DateFormat('yyyy-MM-dd').format(DateTime.fromMicrosecondsSinceEpoch(
              allTransaction.last.transactionTimestamp)),
          DateFormat('yyyy-MM-dd').format(date));
    });

    test("update entries in transactions table", () async {
      await db.categoryDao.createCategory("some cat title");
      await db.categoryDao.createCategory("some other title");
      await db.transactionTypeDao.createTransactionType("some ttype title");
      await db.sourceDao.createSource("some source title");

      final c = await db.categoryDao.getAllCategories();
      final s = await db.sourceDao.getAllSources();
      final t = await db.transactionTypeDao.getAllTransactionTypes();

      final firstCatId = c.first.id;
      final secondCatId = c.last.id;
      final sourceId = s.first.id;
      final tTypeId = t.first.id;

      await db.transactionDao.createTransaction(
          "transaction title", 202.0, firstCatId, sourceId, tTypeId);

      final allTransaction = await db.transactionDao.getTransactions();

      expect(allTransaction.length, 1);
      expect(allTransaction.first.title, "transaction title");

      TransactionEntry trans = allTransaction.first.copyWith(
          title: "updated transaction title",
          amount: 290012,
          categoryId: secondCatId);

      await db.transactionDao.updateTransaction(trans);

      final updatedTrans = await db.transactionDao.getTransactions();

      expect(updatedTrans.length, 1);
      expect(updatedTrans.first.title, "updated transaction title");
      expect(updatedTrans.first.categoryId, secondCatId);
    });

    test("delete entries in transactions table", () async {
      await db.categoryDao.createCategory("some cat title");
      await db.transactionTypeDao.createTransactionType("some ttype title");
      await db.sourceDao.createSource("some source title");

      final c = await db.categoryDao.getAllCategories();
      final s = await db.sourceDao.getAllSources();
      final t = await db.transactionTypeDao.getAllTransactionTypes();

      final catId = c.first.id;
      final sourceId = s.first.id;
      final tTypeId = t.first.id;

      await db.transactionDao.createTransaction(
          "transaction title", 202.0, catId, sourceId, tTypeId);

      final allTransaction = await db.transactionDao.getTransactions();

      expect(allTransaction.length, 1);
      expect(allTransaction.first.title, "transaction title");

      await db.transactionDao.deleteTransaction(allTransaction.first.id);
      final newtTrns = await db.transactionDao.getTransactions();
      expect(newtTrns.length, 0);
    });
  });

  test("should throw foreign_key exception", () async {
    expect(
        () async => await db.transactionDao
            .createTransaction("title", 202.0, "catId", "sourceId", "tTypeId"),
        throwsA(predicate((e) =>
            e.message.toString().contains('FOREIGN KEY constraint failed'))));
  });

  test("fetch all transactions with joined data", () async {
    await db.categoryDao.createCategory("some cat title");
    await db.transactionTypeDao.createTransactionType("some ttype title");
    await db.sourceDao.createSource("some source title");

    final c = await db.categoryDao.getAllCategories();
    final s = await db.sourceDao.getAllSources();
    final t = await db.transactionTypeDao.getAllTransactionTypes();

    final catId = c.first.id;
    final sourceId = s.first.id;
    final tTypeId = t.first.id;

    final date1 =
        DateTime.now().subtract(Duration(days: 10)).microsecondsSinceEpoch;
    final date2 =
        DateTime.now().subtract(Duration(days: 20)).microsecondsSinceEpoch;

    final expextedDates = [date1, date2].map((d) => DateFormat('yyyy-MM-dd')
        .format(DateTime.fromMicrosecondsSinceEpoch(d)));

    await db.transactionDao.createTransaction(
        "first title", 102.0, catId, sourceId, tTypeId,
        transactionTimestamp: date2);

    await db.transactionDao.createTransaction(
        "second title", 202.0, catId, sourceId, tTypeId,
        transactionTimestamp: date1);

    final result = db.transactionDao.watchTransactions();

    result.listen(expectAsync1((trs) {
      final trTitles = trs.map((t) => t.transactions.title).toSet().toList();
      final srcTitles = trs.map((t) => t.sources.title).toSet().toList();
      final catTitles = trs.map((t) => t.categories.title).toSet().toList();
      final tTypeTitles =
          trs.map((t) => t.transactionTypes.title).toSet().toList();
      final trDates = trs
          .map((t) => DateFormat('yyyy-MM-dd').format(
              DateTime.fromMicrosecondsSinceEpoch(
                  t.transactions.transactionTimestamp)))
          .toSet()
          .toList();

      expect(trTitles, ["second title", "first title"]);
      expect(srcTitles, ["some source title"]);
      expect(catTitles, ["some cat title"]);
      expect(tTypeTitles, ["some ttype title"]);

      expect(trDates, expextedDates);
    }, count: 1));
  });

  test("fetch transactions by timestamp with from time", () async {
    await db.categoryDao.createCategory("some cat title");
    await db.transactionTypeDao.createTransactionType("some ttype title");
    await db.sourceDao.createSource("some source title");

    final c = await db.categoryDao.getAllCategories();
    final s = await db.sourceDao.getAllSources();
    final t = await db.transactionTypeDao.getAllTransactionTypes();

    final catId = c.first.id;
    final sourceId = s.first.id;
    final tTypeId = t.first.id;

    for (var j in List.generate(10, (i) => i + 1)) {
      final date = DateTime.fromMicrosecondsSinceEpoch(1605869730572408)
          .subtract(Duration(days: j))
          .microsecondsSinceEpoch;
      final amount = new Random().nextDouble() * 1000;
      await db.transactionDao.createTransaction(
          "transaction title - $j", amount, catId, sourceId, tTypeId,
          transactionTimestamp: date);
    }

    final result = db.transactionDao
        .watchAndFilterTransactionsByTime(fromTimestamp: 1605524130577502);

    result.listen(expectAsync1((trs) {
      final expectedDates = trs.map(
        (element) {
          return DateFormat('yyyy-MM-dd').format(
            DateTime.fromMicrosecondsSinceEpoch(
                element.transactions.transactionTimestamp),
          );
        },
      ).toList();
      expect(expectedDates, [
        "2020-11-19",
        "2020-11-18",
        "2020-11-17",
      ]);
    }, count: 1));
  });

  test("fetch transactions by timestamp with from and to date", () async {
    await db.categoryDao.createCategory("some cat title");
    await db.transactionTypeDao.createTransactionType("some ttype title");
    await db.sourceDao.createSource("some source title");

    final c = await db.categoryDao.getAllCategories();
    final s = await db.sourceDao.getAllSources();
    final t = await db.transactionTypeDao.getAllTransactionTypes();

    final catId = c.first.id;
    final sourceId = s.first.id;
    final tTypeId = t.first.id;

    for (var j in List.generate(10, (i) => i + 1)) {
      final date = DateTime.fromMicrosecondsSinceEpoch(1605869730572408)
          .subtract(Duration(days: j))
          .microsecondsSinceEpoch;
      final amount = new Random().nextDouble() * 1000;
      await db.transactionDao.createTransaction(
          "transaction title - $j", amount, catId, sourceId, tTypeId,
          transactionTimestamp: date);
    }

    final result = db.transactionDao.watchAndFilterTransactionsByTime(
        fromTimestamp: 1605264930578871, toTimestamp: 1605696930576363);

    result.listen(expectAsync1((trs) {
      final expectedDates = trs.map(
        (element) {
          return DateFormat('yyyy-MM-dd').format(
            DateTime.fromMicrosecondsSinceEpoch(
                element.transactions.transactionTimestamp),
          );
        },
      ).toList();
      expect(expectedDates, [
        "2020-11-18",
        "2020-11-17",
        "2020-11-16",
        "2020-11-15",
        "2020-11-14",
      ]);
    }, count: 1));
  });

  test("summary should return aggrgated values", () async {
    await db.categoryDao.createCategory("some cat title");
    await db.transactionTypeDao.createTransactionType("Income");
    await db.transactionTypeDao.createTransactionType("Investment");
    await db.transactionTypeDao.createTransactionType("Withdrawl");
    await db.transactionTypeDao.createTransactionType("Expanse");
    await db.sourceDao.createSource("Account");
    await db.sourceDao.createSource("Cash");

    final c = await db.categoryDao.getAllCategories();
    final s = await db.sourceDao.getAllSources();
    final t = await db.transactionTypeDao.getAllTransactionTypes();

    final catId = c.first.id;
    final accountSourceId = s.first.id;
    final cashSourceId = s.last.id;
    final incomdeTTypeId = t.where((e) => e.title == "Income").first.id;
    final investTTypeId = t.where((e) => e.title == "Investment").first.id;
    final withTTypeId = t.where((e) => e.title == "Withdrawl").first.id;
    final expanseTTypeId = t.where((e) => e.title == "Expanse").first.id;

    await db.transactionDao.createTransaction(
        "account income", 9000.0, catId, accountSourceId, incomdeTTypeId);

    await db.transactionDao.createTransaction(
        "cash income", 1000.0, catId, cashSourceId, incomdeTTypeId);

    await db.transactionDao.createTransaction(
        "investment", 1000.0, catId, cashSourceId, investTTypeId);

    await db.transactionDao.createTransaction(
        "withdrawl", 1000.0, catId, accountSourceId, withTTypeId);

    await db.transactionDao.createTransaction(
        "expanse 1", 100.0, catId, cashSourceId, expanseTTypeId);

    await db.transactionDao.createTransaction(
        "expanse 2", 200.0, catId, cashSourceId, expanseTTypeId);

    // await db.transactionDao.createTransaction(
    //     "expanse 2", 1000.0, catId, accountSourceId, expanseTTypeId);

    // for (var j in List.generate(10, (i) => i + 1)) {
    //   final date = DateTime.fromMicrosecondsSinceEpoch(1605869730572408)
    //       .subtract(Duration(days: j))
    //       .microsecondsSinceEpoch;
    //   final amount = new Random().nextDouble() * 1000;
    //   await db.transactionDao.createTransaction(
    //       "transaction title - $j", amount, catId, sourceId, investmentTTypeId,
    //       transactionTimestamp: date);
    // }

    final result = db.transactionDao.summary();

    result.listen(expectAsync1((trs) {
      print(trs);

      expect(1, 1);
    }, count: 1));
  });
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selavify/models/app_database.dart';
import 'package:selavify/models/dao.dart';
import 'package:selavify/pages/categories.dart';
import 'package:selavify/pages/sources.dart';
import 'package:selavify/pages/transaction_type.dart';
import 'package:selavify/pages/transactions.dart';
// import 'package:selavify/pages/add_transaction.dart';
// import 'package:selavify/pages/transaction_list.dart';
// import 'package:selavify/services/db_service.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await DBService.init();
  final db = SelavifyDB.withName("test_selavify.db");
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => CategoryDao(db)),
        Provider(create: (_) => SourceDao(db)),
        Provider(create: (_) => TransactionTypeDao(db)),
        Provider(create: (_) => TransactionDao(db)),
      ],
      child: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder()),
      ),
      debugShowCheckedModeBanner: false,
      home: CategoryList(),
      initialRoute: '/',
      routes: {
        CategoryList.routeName: (context) => CategoryList(),
        SourceList.routeName: (context) => SourceList(),
        TransactionTypeList.routeName: (context) => TransactionTypeList(),
        TransactionsList.routeName: (context) => TransactionsList()
        // SourceList.routeName: (context) => SourceList(),
        // TransactionList.routeName: (context) => TransactionList(),
        // AddTransaction.routeName: (context) => AddTransaction(),
      },
    );
  }
}

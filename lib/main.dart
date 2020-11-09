import 'package:flutter/material.dart';
import 'package:selavify/pages/add_transaction.dart';
import 'package:selavify/pages/transaction_list.dart';
import 'package:selavify/services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService.init();

  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder()),
      ),
      debugShowCheckedModeBanner: false,
      home: TransactionList(),
      initialRoute: '/',
      routes: {
        TransactionList.routeName: (context) => TransactionList(),
        AddTransaction.routeName: (context) => AddTransaction(),
      },
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selavify/models/app_database.dart';
import 'package:selavify/models/dao.dart';
import 'package:selavify/pages/dashboard_page.dart';
import 'package:selavify/routes.dart';

void main() async {
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
        primarySwatch: Colors.deepOrange,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
      initialRoute: '/',
      routes: routes,
    );
  }
}

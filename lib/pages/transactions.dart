import 'package:flutter/material.dart';
import 'package:selavify/widgets/drawer_menu.dart';
import 'package:selavify/widgets/icon_widgets.dart';

class TransactionsList extends StatelessWidget {
  static final routeName = '/transacrions';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: Center(
        child: Text("Transactions"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: AddNewItem(),
      ),
      drawer: DrawerMenu(),
    );
  }
}

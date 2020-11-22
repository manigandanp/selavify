import 'package:flutter/material.dart';
import 'package:selavify/pages/categories.dart';
import 'package:selavify/pages/sources.dart';
import 'package:selavify/pages/transaction_type.dart';
import 'package:selavify/pages/transactions.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () {},
            title: _styledText("Home"),
            leading: _styledIcon(context, Icons.home_outlined),
          ),
          Divider(),
          ListTile(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(CategoryList.routeName),
            title: _styledText("Category"),
            leading: _styledIcon(context, Icons.category_outlined),
          ),
          Divider(),
          ListTile(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(SourceList.routeName),
            title: _styledText("Sources"),
            leading: _styledIcon(context, Icons.source_outlined),
          ),
          Divider(),
          ListTile(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(TransactionTypeList.routeName),
            title: _styledText("Transaction Types"),
            leading: _styledIcon(context, Icons.transform_outlined),
          ),
          Divider(),
          ListTile(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(TransactionsList.routeName),
            title: _styledText("Transactions"),
            leading: _styledIcon(context, Icons.money_outlined),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _styledText(title) => Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _styledIcon(BuildContext context, IconData icon) =>
      Icon(icon, color: Theme.of(context).primaryColor);
}

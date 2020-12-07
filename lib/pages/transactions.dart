import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:selavify/models/dao.dart';
import 'package:selavify/models/models.dart';
import 'package:selavify/widgets/drawer_menu.dart';
import 'package:selavify/widgets/icon_widgets.dart';
import 'package:selavify/pages/add_transaction.dart';

class TransactionsList extends StatelessWidget {
  static final routeName = '/transacrions';
  static const _CURRENCY_SYMBOL = "₹";
  @override
  Widget build(BuildContext context) {
    final transactionDao = Provider.of<TransactionDao>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: StreamBuilder<List<TransactionWithCategorySourceAndTType>>(
        stream: transactionDao.watchTransactions(),
        builder: (context,
            AsyncSnapshot<List<TransactionWithCategorySourceAndTType>>
                snapshot) {
          final items = snapshot.data ?? List();
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (listViewCtx, index) {
              final item = items[index];
              return _listItem(item, listViewCtx, transactionDao);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddNewTransaction(title: "Add New Transaction"),
            ),
          );
        },
        child: AddNewItem(),
      ),
      drawer: DrawerMenu(),
    );
  }

  Widget _listItem(TransactionWithCategorySourceAndTType item,
      BuildContext context, TransactionDao transactionDao) {
    final isIncome = item.transactionTypes.title.toLowerCase() == "income";
    final color = isIncome ? Colors.green : Colors.red;

    return Slidable(
      key: ValueKey(item.transactions.id),
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        IconSlideAction(
          caption: "Delete",
          icon: Icons.delete,
          color: Colors.red,
          onTap: () {
            transactionDao.deleteTransaction(item.transactions.id);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("Deleted Successflly!")));
          },
        ),
        IconSlideAction(
          caption: "Edit",
          icon: Icons.edit,
          color: Colors.red,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNewTransaction(
                  title: "Edit Transaction",
                  oldTransaction: item.transactions,
                ),
              ),
            );
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("Edited Successfully!!")));
          },
        ),
      ],
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color[200],
            child: Text(
              item.transactionTypes.title[0],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          title: Text(item.transactions.title),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      item.categories.title,
                    ),
                    SizedBox(width: 5),
                    Text("|"),
                    SizedBox(width: 5),
                    Text(
                      item.sources.title,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  _formatTimestamp(item.transactions.transactionTimestamp),
                ),
              ],
            ),
          ),
          trailing: _styleAmount(item.transactions.amount, isIncome, color),
        ),
      ),
    );
  }

  String _formatTimestamp(int timestamp) => DateFormat("dd-MM-yyyy hh:ss")
      .format(DateTime.fromMillisecondsSinceEpoch(timestamp));

  Widget _styleAmount(double amount, bool isIncome, Color color) => Text(
        "${isIncome ? "+" : "-"} $_CURRENCY_SYMBOL ${amount.toString()}",
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
}

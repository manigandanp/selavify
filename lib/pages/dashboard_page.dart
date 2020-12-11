import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selavify/models/dao.dart';
import 'package:selavify/models/summary_model.dart';
import 'package:selavify/services/dashboard_service.dart';
import 'package:selavify/widgets/drawer_menu.dart';
import 'package:selavify/widgets/icon_widgets.dart';

import 'add_transaction.dart';

class Dashboard extends StatelessWidget {
  static final routeName = "/dashboard";
  @override
  Widget build(BuildContext context) {
    final TransactionDao dao = Provider.of<TransactionDao>(context);
    final DashboardService service = DashboardService(dao);
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: StreamBuilder<List<Summary>>(
          stream: service.watchSummary(),
          builder: (context, AsyncSnapshot<List<Summary>> snapshot) {
            final Summary summary = snapshot.data[0] ?? {};

            if (snapshot.data != null)
              return SummaryList(summary: summary);
            else
              return Center(
                child: CircularProgressIndicator(),
              );
          }),
      drawer: DrawerMenu(),
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
    );
  }
}

class SummaryList extends StatelessWidget {
  const SummaryList({
    Key key,
    @required this.summary,
  }) : super(key: key);

  final Summary summary;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildSummaryCard("Income", summary.income),
              buildSummaryCard("Expanse", summary.expanse),
              buildSummaryCard("Investment", summary.investment),
              Card(
                child: ListTile(
                  title: Text("Withdrawl"),
                  trailing: Text(summary.withdrawl.toString()),
                ),
              ),
            ],
          ),
          Container(
            child: buildSummaryCard("Balance", summary.balance),
            margin: EdgeInsets.only(top: 50),
          ),
        ],
      ),
    );
  }

  Card buildSummaryCard(String title, SummaryObj obj) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text('Cash: ${obj.cash} | Account: ${obj.account}'),
        trailing: Text(obj.total.toString()),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selavify/models/dao.dart';
import 'package:selavify/models/summary_model.dart';
import 'package:selavify/services/dashboard_service.dart';
import 'package:selavify/services/google_drive_service.dart';
import 'package:selavify/utils/file_helper.dart';
import 'package:selavify/utils/utils.dart';
import 'package:selavify/widgets/drawer_menu.dart';
import 'package:selavify/widgets/icon_widgets.dart';

import 'add_transaction.dart';

class Dashboard extends StatelessWidget {
  void backupToDrive(DashboardService service, context) async {
    final folderName = "backup";
    final dateStr = Utils.getCurrentDateAsString();
    final fileName = "transactions_$dateStr.csv";
    final fileHelper = FileUtils(folderName, fileName);
    var transactions = await service.getTransactionsAsCsv(withHeader: true);
    var content = transactions.join("\n");
    File f = await fileHelper.writeContent(content);
    await GoogleDriveFacade().uploadFile(f, fileName);
    await fileHelper.deleteFile(f);
    print("file uploaded sucessfully");
    // await GoogleDriveFacade().signOut();
    // showDialog(
    //   context: context,
    //   barrierDismissible: true,
    //   builder: (BuildContext context) {
    //     return Dialog(
    //       child: new Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           new CircularProgressIndicator(),
    //           new Text("Loading"),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }

  static final routeName = "/dashboard";
  @override
  Widget build(BuildContext context) {
    final TransactionDao dao = Provider.of<TransactionDao>(context);
    final DashboardService service = DashboardService(dao);
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sync,
            ),
            onPressed: () => backupToDrive(service, context),
          ),
        ],
      ),
      body: StreamBuilder<List<Summary>>(
          stream: service.watchSummary(),
          builder: (context, AsyncSnapshot<List<Summary>> snapshot) {
            if (snapshot.data != null) {
              final Summary summary = snapshot.data[0];
              return SummaryList(summary: summary);
            } else
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selavify/models/dao.dart';
import 'package:selavify/models/summary_model.dart';
import 'package:selavify/services/dashboard_service.dart';
import 'package:selavify/widgets/drawer_menu.dart';

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
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Text("Income"),
                            subtitle: Text(
                                'Cash: ${summary.income.cash} | Account: ${summary.income.account}'),
                            trailing: Text(summary.income.total.toString()),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text("Expanse"),
                            subtitle: Text(
                                'Cash: ${summary.expanse.cash} | Account: ${summary.expanse.account}'),
                            trailing: Text(summary.expanse.total.toString()),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text("Investment"),
                            subtitle: Text(
                                'Cash: ${summary.investment.cash} | Account: ${summary.investment.account}'),
                            trailing: Text(summary.investment.total.toString()),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text("Withdrawl"),
                            trailing: Text(summary.withdrawl.toString()),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      child: ListTile(
                        title: Text("Balance"),
                        subtitle: Text(
                            'Cash: ${summary.balance.cash} | Account: ${summary.balance.account}'),
                        trailing: Text(summary.balance.total.toString()),
                      ),
                    )
                  ],
                ),
              );
            else
              return Center(
                child: CircularProgressIndicator(),
              );
          }),
      drawer: DrawerMenu(),
    );
  }
}

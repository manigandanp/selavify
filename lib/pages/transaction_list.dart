import 'package:flutter/material.dart';
import 'package:selavify/models/transaction.dart';
import 'package:selavify/pages/add_transaction.dart';
import 'package:selavify/services/transaction_service.dart';

class TransactionList extends StatefulWidget {
  static final routeName = '/transaction_list';
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Future<List<Transaction>> transactions;
  @override
  void initState() {
    super.initState();
    transactions = Future.delayed(
      Duration(seconds: 3),
      () => TransactionService.fetchTransactions(),
    );
  }

  Widget emptyTransaction = Center(
    child: Text("No Transactions!!"),
  );

  Widget transactionsListView(transactions) => ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (BuildContext ctx, int i) =>
            transactionItem(transactions[i].toJson()),
      );

  Widget transactionItem(transaction) => ListTile(
        title: Text(transaction['id']),
        trailing: Text(transaction['transactionAmount'].toString()),
        leading: Text(transaction['categoryId']),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selavify"),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: transactions,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.length > 0
                ? transactionsListView(snapshot.data)
                : emptyTransaction;
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Error while fetching data from db"),
                  Text(snapshot.error.toString()),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      drawer: Drawer(
        child: Text("Menu"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddTransaction.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

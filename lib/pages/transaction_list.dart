import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selavify/models/transaction.dart';
import 'package:selavify/pages/add_transaction.dart';
import 'package:selavify/services/transaction_service.dart';

class TransactionList extends StatefulWidget {
  static final routeName = '/transaction_list';
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Future<List<Transaction>> transactionsFuture;
  List<Transaction> transactions;
  @override
  void initState() {
    super.initState();
    transactionsFuture = Future.delayed(
      Duration(seconds: 3),
      () => TransactionService.fetchTransactions(),
    );
  }

  Widget emptyTransaction = Center(
    child: Text("No Transactions!!"),
  );

  Widget transactionsListView(transactions) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (BuildContext ctx, int i) =>
              transactionItem(transactions[i].toJson()),
        ),
      );

  Widget transactionItem(transaction) => Dismissible(
        key: ValueKey(transaction['id']),
        child: Card(
          color: transaction['transactionTypeId'] == "income_id"
              ? Colors.green[50]
              : Colors.red[50],
          elevation: 5,
          child: ListTile(
            title: titleWidget(transaction['transactionTitle']),
            subtitle: Text(
              DateFormat("dd/MM/yyyy hh:ss").format(
                DateTime.fromMillisecondsSinceEpoch(
                  transaction['transactionTimestamp'],
                ),
              ),
            ),
            leading:
                transactionType(transaction['transactionTypeId'].toString()),
            trailing: amountWidget(transaction['transactionAmount'].toString()),
          ),
        ),
      );

  Widget amountWidget(amount) => Text(
        "₹ ${amount}",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );

  Widget titleWidget(title) => Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );

  Widget transactionType(transactionTypeId) {
    return CircleAvatar(
      backgroundColor: Colors.pink[50],
      child: Text(
        transactionTypeId == "income_id" ? "I" : "E",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selavify"),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            transactions = snapshot.data;
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
        onPressed: () async {
          var newTransaction =
              await Navigator.of(context).pushNamed(AddTransaction.routeName);
          if (newTransaction == null)
            return;
          else
            setState(() {
              transactions.add(newTransaction);
            });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selavify/models/app_database.dart';
import 'package:selavify/models/dao.dart';
import 'package:selavify/widgets/bottom_sheet_with_form_field.dart';
import 'package:selavify/widgets/card_item.dart';
import 'package:selavify/widgets/dismiss_item.dart';
import 'package:selavify/widgets/drawer_menu.dart';
import 'package:selavify/widgets/icon_widgets.dart';

class TransactionTypeList extends StatelessWidget {
  static final routeName = "/transactionTypeList";
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final tTypeDao = Provider.of<TransactionTypeDao>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Transaction Type"),
      ),
      body: StreamBuilder<List<TransactionType>>(
        stream: tTypeDao.watchTransactionTypes(),
        builder: (ctx, AsyncSnapshot<List<TransactionType>> snapshot) {
          final data = snapshot.data ?? List();
          return ListView.builder(
            itemBuilder: (listViewCtx, i) {
              final item = data[i];
              return DismissibleListItem(
                deleteHandler: () => tTypeDao.deleteTransactionType(item.id),
                itemId: item.id,
                child: CartItem(
                  title: item.title,
                  editBottomSheet: _editBottomSheet(
                      listViewCtx, tTypeDao, item, _scaffoldKey),
                  createdTimestamp: item.createdDate,
                ),
              );
            },
            itemCount: data.length,
          );
        },
      ),
      floatingActionButton: CustomBottmSheetWithFormField(
        context: context,
        scaffoldKey: _scaffoldKey,
        addNewItem: (title) => _insertTransactionType(tTypeDao, title),
        labelText: "Transaction Type",
        child: FloatingActionButton(
          onPressed: null,
          child: const AddNewItem(),
        ),
      ),
      drawer: DrawerMenu(),
    );
  }

  Future<int> _insertTransactionType(
          TransactionTypeDao transactionTypeDao, String title) async =>
      await transactionTypeDao.createTransactionType(title);

  Widget _editBottomSheet(
          BuildContext context,
          TransactionTypeDao transactionTypeDao,
          TransactionType tType,
          GlobalKey<ScaffoldState> scaffoldKey) =>
      CustomBottmSheetWithFormField(
        context: context,
        addNewItem: (title) =>
            _updateTransactionType(transactionTypeDao, tType, title),
        child: const EditItem(),
        labelText: "Transaction Type",
        scaffoldKey: scaffoldKey,
        initalValue: tType.title,
      );

  Future _updateTransactionType(TransactionTypeDao transactionTypeDao,
          TransactionType tType, String title) async =>
      await transactionTypeDao
          .updateTransactionType(tType.copyWith(title: title));
}

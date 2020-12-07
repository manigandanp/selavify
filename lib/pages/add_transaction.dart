import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:selavify/models/app_database.dart';
import 'package:selavify/models/dao.dart';
import 'package:selavify/utils/transactions_helper.dart';

class AddNewTransaction extends StatelessWidget {
  final String title;
  final TransactionEntry oldTransaction;

  AddNewTransaction({
    this.title,
    this.oldTransaction,
  });

  static final routeName = "/addNewTranasaction";
  final GlobalKey _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final categoryDao = Provider.of<CategoryDao>(context);
    final sourceDao = Provider.of<SourceDao>(context);
    final tTypeDao = Provider.of<TransactionTypeDao>(context);
    final transactionDao = Provider.of<TransactionDao>(context);
    final isEditPage = oldTransaction != null;
    return Scaffold(
      appBar: AppBar(title: Text(title ?? "Add New Transaction")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FormBuilder(
            key: _fbKey,
            child: Column(
              children: [
                FormBuilderDateTimePicker(
                  fieldLabelText: "Choose Date",
                  name: "transactionTimestamp",
                  inputType: InputType.both,
                  initialValue: isEditPage
                      ? DateTime.fromMillisecondsSinceEpoch(
                          oldTransaction.transactionTimestamp)
                      : DateTime.now(),
                  format: DateFormat("dd-MM-yyyy hh:ss"),
                  resetIcon: null,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  valueTransformer: (dateStr) => dateStr.millisecondsSinceEpoch,
                ),
                SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                  name: "transactionTitle",
                  decoration: InputDecoration(
                    labelText: "Transaction Title",
                    hintText: "Transaction Title",
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  initialValue: isEditPage ? oldTransaction.title : "",
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                    name: "amount",
                    decoration: InputDecoration(
                      labelText: "Transaction Amount",
                      hintText: "Transaction Amount",
                    ),
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    valueTransformer: (val) => double.parse(val),
                    initialValue:
                        isEditPage ? oldTransaction.amount.toString() : ""),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder<List<Category>>(
                  stream: categoryDao.watchCategories(),
                  builder: (context, AsyncSnapshot<List<Category>> snapshot) {
                    final items = snapshot.data ?? List();
                    final initialValue =
                        isEditPage ? oldTransaction.categoryId : null;
                    return _dropdownBuilder(
                        context, items, "Category", initialValue);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder<List<Source>>(
                  stream: sourceDao.watchSources(),
                  builder: (context, AsyncSnapshot<List<Source>> snapshot) {
                    final items = snapshot.data ?? List();
                    final initialValue =
                        isEditPage ? oldTransaction.sourceId : null;
                    return _dropdownBuilder(
                        context, items, "Source", initialValue);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder<List<TransactionType>>(
                  stream: tTypeDao.watchTransactionTypes(),
                  builder:
                      (context, AsyncSnapshot<List<TransactionType>> snapshot) {
                    final items = snapshot.data ?? List();
                    final initialValue =
                        isEditPage ? oldTransaction.transactionTypeId : null;
                    return _dropdownBuilder(
                        context, items, "Transaction Type", initialValue);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  color: Theme.of(context).primaryColor,
                  child: ElevatedButton(
                    onPressed: () =>
                        _submitHandler(context, transactionDao, isEditPage),
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitHandler(
      BuildContext context, TransactionDao transactionDao, bool isEditPage) {
    GlobalKey<FormBuilderState> fbKey = _fbKey;
    if (fbKey.currentState.saveAndValidate()) {
      var helper = TransactionsHelper(transactionDao);
      Map<String, dynamic> json = fbKey.currentState.value;
      if (isEditPage)
        helper.updateTransaction(oldTransaction, json);
      else
        helper.createTransaction(json);

      print(fbKey.currentState.value);
      Navigator.pop(context);
    } else
      print("something went wrong");
  }

  FormBuilderDropdown _dropdownBuilder(BuildContext context, List items,
          String labelText, String initialValue) =>
      FormBuilderDropdown(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        name: labelText.toLowerCase().split(" ").join("_"),
        items: _menuItemBuilder(items),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
        initialValue: initialValue,
      );

  List<DropdownMenuItem> _menuItemBuilder(List items) {
    List<DropdownMenuItem> dropDownItems = items
        .map(
          (item) => DropdownMenuItem(
            value: item.id,
            child: Text(item.title),
          ),
        )
        .toList();
    return [...dropDownItems];
  }
}

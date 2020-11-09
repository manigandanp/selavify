import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:selavify/models/category.dart';
import 'package:selavify/models/source.dart';
import 'package:selavify/models/transaction.dart';
import 'package:selavify/models/transaction_type.dart';
import 'package:selavify/services/db_service.dart';
import 'package:selavify/services/transaction_service.dart';
import 'package:selavify/widgets/custom_dropdown.dart';

class AddTransaction extends StatefulWidget {
  static final routeName = "/add_transaction";

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<Map<String, dynamic>> dropdownValues;

  Widget forms({
    context,
    transactionTypeItems,
    sourceItems,
    categoryItems,
    formKey,
  }) =>
      FormBuilder(
        key: formKey,
        child: Column(
          children: [
            datePicker,
            spacer,
            transactionTypeCustomDropdown(transactionTypeItems),
            spacer,
            sourceCustomDropdown(sourceItems),
            spacer,
            categoryCustomDropdown(categoryItems),
            spacer,
            formTextField("transactionTitle", "Transaction Tilte"),
            spacer,
            transactionAmount,
            spacer,
            submitButton(context, formKey),
          ],
        ),
      );

  final Widget spacer = SizedBox(
    height: 15,
  );

  Widget transactionTypeCustomDropdown(tType) => DropdownWithBottomModal(
        attribute: "transactionTypeId",
        items: tType,
        hint: "Transaction Type",
        childForm: formTextField("transactionType", "Transaction Type"),
      );

  Widget sourceCustomDropdown(sources) => DropdownWithBottomModal(
        attribute: "sourceId",
        items: sources,
        hint: "Source",
        childForm: formTextField("source", "Source"),
      );

  Widget categoryCustomDropdown(categories) => DropdownWithBottomModal(
        attribute: "categoryId",
        items: categories,
        hint: "Category",
        childForm: formTextField("category", "Category"),
      );

  final Widget datePicker = FormBuilderDateTimePicker(
    attribute: 'transactionTimestamp',
    inputType: InputType.both,
    initialValue: DateTime.now(),
    validators: [
      FormBuilderValidators.required(),
    ],
    format: DateFormat("dd-MM-yyyy hh:ss"),
    resetIcon: null,
    valueTransformer: (dateStr) => dateStr.millisecondsSinceEpoch,
  );

  Widget formTextField(attribute, labelText) => FormBuilderTextField(
        attribute: attribute, //"transactionTitle",
        decoration: InputDecoration(
          labelText: labelText, //"Transaction Title",
          hintText: labelText, //"Title",
        ),
        validators: [
          FormBuilderValidators.required(),
        ],
      );

  final Widget transactionAmount = FormBuilderTextField(
    attribute: "transactionAmount",
    decoration: InputDecoration(
      labelText: "Transaction Amount",
      hintText: "Amount",
    ),
    keyboardType: TextInputType.number,
    validators: [
      FormBuilderValidators.required(),
      FormBuilderValidators.numeric()
    ],
  );

  void _submitAction(formKey) async {
    if (formKey.currentState.saveAndValidate()) {
      Map<String, dynamic> response =
          await TransactionService.addTransaction(formKey.currentState.value);
      Navigator.of(context).pop(Transaction.fromJson(response));
    } else {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
        ),
      );
    }
  }

  Widget submitButton(context, formKey) => ElevatedButton(
        onPressed: () => _submitAction(formKey),
        child: Text(
          "Submit",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    dropdownValues = DBService.queryDefaultValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Transaction"),
      ),
      body: FutureBuilder(
        future: dropdownValues,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error loading dropdownValues " + snapshot.error),
            );
          } else if (snapshot.hasData) {
            List<TransactionType> tType = snapshot.data["transactionType"];
            List<Category> category = snapshot.data["category"];
            List<Source> source = snapshot.data["source"];

            return SingleChildScrollView(
              child: Padding(
                child: forms(
                  context: context,
                  formKey: _fbKey,
                  transactionTypeItems: tType,
                  categoryItems: category,
                  sourceItems: source,
                ),
                padding: EdgeInsets.all(15),
              ),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}

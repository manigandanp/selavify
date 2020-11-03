import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
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

  final tType = {
    "income_id": "Income",
    "expanses_id": "Expanses",
  };

  final source = {
    "account_id": "Account",
    "cash_id": "Cash",
  };

  final categories = {
    "cat_id_1": "Salary",
    "cat_id_2": "Grocery",
    "cat_id_3": "Entertainment",
  };

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
            categoryCustomDropdown(categories),
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
        validators: [FormBuilderValidators.required()],
        childForm: formTextField("transactionType", "Transaction Type"),
      );

  Widget sourceCustomDropdown(sources) => DropdownWithBottomModal(
        attribute: "sourceId",
        items: sources,
        hint: "Source",
        validators: [FormBuilderValidators.required()],
        childForm: formTextField("source", "Source"),
      );

  Widget categoryCustomDropdown(categories) => DropdownWithBottomModal(
        attribute: "categoryId",
        items: categories,
        hint: "Category",
        validators: [FormBuilderValidators.required()],
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

  Widget submitButton(context, formKey) => RaisedButton(
        onPressed: () {
          if (formKey.currentState.saveAndValidate()) {
            print(formKey.currentState.value);
            TransactionService.addTransaction(formKey.currentState.value);
            Navigator.of(context).pop();
          } else {
            _scaffoldKey.currentState.hideCurrentSnackBar();
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("Some thing went wrong"),
              ),
            );
          }
        },
        child: Text("Submit"),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Transaction"),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Padding(
            child: forms(
              context: context,
              formKey: _fbKey,
              transactionTypeItems: tType,
              categoryItems: categories,
              sourceItems: source,
            ),
            padding: EdgeInsets.all(15),
          ),
        ),
      ),
    );
  }
}

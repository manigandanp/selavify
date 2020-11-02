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
  final GlobalKey<FormBuilderState> _categoryKey =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _sourceKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _transactionKey =
      GlobalKey<FormBuilderState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final tType = {
    "income_id": "Income",
    "expanses_id": "Expanses",
  };

  final source = {
    "account_id": "Account",
    "cash_id": "Cash",
    "new": "Add New",
  };

  final categories = {
    "cat_id_1": "Salary",
    "cat_id_2": "Grocery",
    "cat_id_3": "Entertainment",
    "new": "Add New",
  };

  Widget forms({
    context,
    transactionTypeItems,
    sourceItems,
    categoryItems,
    formKey,
    transactionTypeKey,
    categoryKey,
    sourceKey,
  }) =>
      FormBuilder(
        key: formKey,
        child: Column(
          children: [
            datePicker,
            spacer,
            transactionTypeCustomDropdown(transactionTypeItems),
            // transactionTypeDropDown(context, transactionTypeItems, categoryKey),
            spacer,
            sourceTypeDropDown(context, sourceItems, _sourceKey),
            spacer,
            categoryDropDown(context, categories, categoryKey),
            spacer,
            formTextField("transactionTitle", "Transaction Tilte", "Title"),
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
      attribute: "transactionTypeId", items: tType, hint: "Transaction Type");

  List<DropdownMenuItem> dropDownItems(items) => items.keys
      .map<DropdownMenuItem>((t) => DropdownMenuItem(
            child: Text(items[t]),
            value: t,
          ))
      .toList();

  Widget transactionTypeDropDown(context, items, categoryKey) => buildDropdown(
        attribute: "transactionTypeId",
        items: items,
        hint: "Transaction Type",
        onChange: (value) {
          if (value == "new")
            addNewEntry(
              context,
              "Add New Transaction Type",
              categoryKey,
              formTextField(
                  "transactionType", "Transaction Type", "Transaction Type"),
            );
        },
      );

  Widget sourceTypeDropDown(context, items, sourceKey) => buildDropdown(
        attribute: "transactionSourceId",
        items: items,
        hint: "Source",
        onChange: (value) {
          if (value == "new")
            addNewEntry(
              context,
              "Add New Source",
              sourceKey,
              formTextField("source", "Source", "Source"),
            );
        },
      );

  Widget categoryDropDown(context, items, categoryKey) => buildDropdown(
        attribute: "categoryId",
        items: items,
        hint: "Category",
        onChange: (value) {
          if (value == "new")
            addNewEntry(
              context,
              "Add New Category",
              categoryKey,
              formTextField("category", "Category", "Category"),
            );
        },
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

  Widget formTextField(attribute, labelText, hintText) => FormBuilderTextField(
        attribute: attribute, //"transactionTitle",
        decoration: InputDecoration(
          labelText: labelText, //"Transaction Title",
          hintText: hintText, //"Title",
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

  Future addNewEntry(context, title, formKey, textField) =>
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(title),
                  ),
                  FormBuilder(
                    key: formKey,
                    child: Column(
                      children: [
                        textField,
                        spacer,
                        submitButton(context, formKey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildDropdown({attribute, items, hint, onChange}) {
    return FormBuilderDropdown(
      attribute: attribute,
      items: dropDownItems(items),
      hint: Text(hint),
      onChanged: onChange,
      validators: [
        FormBuilderValidators.required(errorText: "Please select something")
      ],
    );
  }

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
              transactionTypeKey: _transactionKey,
              sourceKey: _sourceKey,
              categoryKey: _categoryKey,
            ),
            padding: EdgeInsets.all(15),
          ),
        ),
      ),
    );
  }
}

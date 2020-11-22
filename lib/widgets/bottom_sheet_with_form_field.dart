import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomBottmSheetWithFormField extends StatelessWidget {
  final BuildContext context;
  final Function addNewItem;
  final Widget child;
  final String labelText;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String initalValue;

  CustomBottmSheetWithFormField(
      {@required this.context,
      @required this.addNewItem,
      @required this.child,
      @required this.labelText,
      @required this.scaffoldKey,
      this.initalValue});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _showModalSheet(context);
        },
        child: child);
  }

  void _showModalSheet(BuildContext context) {
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    final String headText = initalValue == null ? "Add" : "Edit";
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(
          top: const Radius.circular(15.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "$headText $labelText",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _formBuilder(formKey, headText),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FormBuilder _formBuilder(
          GlobalKey<FormBuilderState> formKey, String headText) =>
      FormBuilder(
        key: formKey,
        child: Column(
          children: [
            FormBuilderTextField(
              attribute: "title",
              decoration: InputDecoration(
                labelText: labelText,
                hintText: labelText,
              ),
              initialValue: initalValue,
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _handleFomrSubmit(formKey, headText),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  void _handleFomrSubmit(GlobalKey<FormBuilderState> formKey, String headText) {
    if (formKey.currentState.saveAndValidate()) {
      final value = formKey.currentState.value;
      addNewItem(value["title"]);
      Navigator.pop(context);
      scaffoldKey.currentState.hideCurrentSnackBar();
      scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("${headText}ed Successfully!!")));
    } else {
      scaffoldKey.currentState.hideCurrentSnackBar();
      scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text("Something Went Wrong :(")));
      print("error");
    }
  }
}

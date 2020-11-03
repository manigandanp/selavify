import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DropdownWithBottomModal<T> extends StatefulWidget {
  final Map<String, dynamic> items;
  final String attribute;
  final String hint;
  final InputDecoration decoration;
  final List<FormFieldValidator<T>> validators;
  final Widget childForm;

  DropdownWithBottomModal({
    @required this.items,
    this.attribute,
    this.hint,
    this.decoration,
    this.validators = const [],
    this.childForm,
  });

  @override
  _DropdownWithBottomModalState createState() =>
      _DropdownWithBottomModalState();
}

class _DropdownWithBottomModalState extends State<DropdownWithBottomModal> {
  List<DropdownMenuItem> menuItems;

  DropdownMenuItem addNewMenuItem = DropdownMenuItem(
    value: "add_new",
    child: Text("Add New"),
  );

  final GlobalKey<FormBuilderState> innerFormKey =
      GlobalKey<FormBuilderState>();

  Widget innerForm(child) => SingleChildScrollView(
        child: Container(
          child: FormBuilder(
            key: innerFormKey,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.ac_unit_sharp),
                  title: Text(
                    "Add New",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                child,
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
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
          ),
        ),
      );

  void _showModalSheet({value, parentContext, Widget child}) {
    if (value == "add_new") {
      showModalBottomSheet(
        context: parentContext,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15.0),
          ),
        ),
        isScrollControlled: true,
        builder: (ctx) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: innerForm(child),
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    menuItems = [
      ...widget.items.keys
          .map<DropdownMenuItem>(
            (key) => DropdownMenuItem(
              value: key,
              child: Text(widget.items[key]),
            ),
          )
          .toList(),
      addNewMenuItem
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      attribute: widget.attribute,
      decoration: widget.decoration ?? new InputDecoration(),
      validators: widget.validators,
      hint: Text(widget.hint),
      items: menuItems,
      onChanged: (value) => _showModalSheet(
          value: value, parentContext: context, child: widget.childForm),
    );
  }
}

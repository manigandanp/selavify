import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:selavify/models/model.dart';

class DropdownWithBottomModal<T> extends StatefulWidget {
  final List<Model> items;
  final String attribute;
  final String hint;
  final InputDecoration decoration;
  final List<FormFieldValidator<T>> validators;
  final Widget childForm;

  final _addNewId = "add_new";

  DropdownWithBottomModal({
    @required this.items,
    this.attribute,
    this.hint,
    this.decoration,
    this.validators,
    this.childForm,
  });

  @override
  _DropdownWithBottomModalState createState() =>
      _DropdownWithBottomModalState();
}

class _DropdownWithBottomModalState extends State<DropdownWithBottomModal> {
  List<DropdownMenuItem> menuItems;

  DropdownMenuItem addNewMenuItem() => DropdownMenuItem(
        value: widget._addNewId,
        child: Builder(
          builder: (ctx) => Text(
            "Add New",
            style: TextStyle(
              color: Theme.of(ctx).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  final GlobalKey<FormBuilderState> innerFormKey =
      GlobalKey<FormBuilderState>();

  Widget innerForm(child) => SingleChildScrollView(
        child: Container(
          child: FormBuilder(
            key: innerFormKey,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Add New Item",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  child,
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
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
      ...widget.items
          .map<DropdownMenuItem>(
            (model) => DropdownMenuItem(
              value: model.id,
              child: Text(model.title),
            ),
          )
          .toList(),
      addNewMenuItem()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      attribute: widget.attribute,
      decoration: widget.decoration ?? new InputDecoration(),
      validators: [
        FormBuilderValidators.required(),
        (val) {
          if (val.toLowerCase() == widget._addNewId)
            return "Value must not be Add New";
        },
      ],
      hint: Text(widget.hint),
      items: menuItems,
      onChanged: (value) => _showModalSheet(
          value: value, parentContext: context, child: widget.childForm),
    );
  }
}

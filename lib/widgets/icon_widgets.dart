import 'package:flutter/material.dart';

class AddNewItem extends StatelessWidget {
  const AddNewItem();
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.add);
  }
}

class EditItem extends StatelessWidget {
  const EditItem();
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.edit);
  }
}

class DeleteItem extends StatelessWidget {
  const DeleteItem();
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.delete);
  }
}

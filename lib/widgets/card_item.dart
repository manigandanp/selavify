import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartItem extends StatelessWidget {
  final String title;
  final Widget editBottomSheet;
  final int createdTimestamp;
  CartItem(
      {@required this.title,
      @required this.editBottomSheet,
      @required this.createdTimestamp});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            title[0].toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(title.toUpperCase()),
        subtitle: _subTitle(createdTimestamp),
        trailing: editBottomSheet,
      ),
    );
  }

  Widget _subTitle(timestamp) => Text(
        DateFormat("dd-MM-yyyy hh:mm")
            .format(DateTime.fromMillisecondsSinceEpoch(createdTimestamp)),
      );
}

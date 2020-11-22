import 'package:flutter/material.dart';
import 'package:selavify/widgets/icon_widgets.dart';

class DismissibleListItem extends StatelessWidget {
  final Function deleteHandler;
  final String itemId;
  final Widget child;

  DismissibleListItem({
    @required this.deleteHandler,
    @required this.itemId,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.amber,
        child: const Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: const DeleteItem(),
        ),
      ),
      onDismissed: (DismissDirection direction) {
        deleteHandler();
      },
      key: ValueKey(itemId),
      child: child,
    );
  }
}

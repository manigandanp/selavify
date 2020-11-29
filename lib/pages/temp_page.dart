import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TempPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temp Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.50,
          child: Container(
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigoAccent,
                child: Text('some text'),
                foregroundColor: Colors.white,
              ),
              title: Text('Tile'),
              subtitle: Text('SlidableDrawerDelegate'),
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: 'Archive',
              color: Colors.blue,
              icon: Icons.archive,
              onTap: () => print('Archive'),
            ),
            // IconSlideAction(
            //   caption: 'Share',
            //   color: Colors.indigo,
            //   icon: Icons.share,
            //   onTap: () => print('Share'),
            // ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'More',
              color: Colors.black45,
              icon: Icons.more_horiz,
              onTap: () => print('More'),
            ),
            // IconSlideAction(
            //   caption: 'Delete',
            //   color: Colors.red,
            //   icon: Icons.delete,
            //   onTap: () => print('Delete'),
            // ),
          ],
        ),
      ),
    );
  }
}

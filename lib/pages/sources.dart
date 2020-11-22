import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selavify/models/app_database.dart';
import 'package:selavify/models/dao.dart';
import 'package:selavify/widgets/bottom_sheet_with_form_field.dart';
import 'package:selavify/widgets/card_item.dart';
import 'package:selavify/widgets/dismiss_item.dart';
import 'package:selavify/widgets/drawer_menu.dart';
import 'package:selavify/widgets/icon_widgets.dart';

class SourceList extends StatelessWidget {
  static final routeName = "/sourceList";
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final sourceDao = Provider.of<SourceDao>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Sources"),
      ),
      body: StreamBuilder<List<Source>>(
        stream: sourceDao.watchSources(),
        builder: (ctx, AsyncSnapshot<List<Source>> snapshot) {
          final data = snapshot.data ?? List();
          return ListView.builder(
            itemBuilder: (listViewCtx, i) {
              final item = data[i];
              return DismissibleListItem(
                deleteHandler: () => sourceDao.deleteSource(item.id),
                itemId: item.id,
                child: CartItem(
                  title: item.title,
                  editBottomSheet: _editBottomSheet(
                      listViewCtx, sourceDao, item, _scaffoldKey),
                  createdTimestamp: item.createdDate,
                ),
              );
            },
            itemCount: data.length,
          );
        },
      ),
      floatingActionButton: CustomBottmSheetWithFormField(
        context: context,
        scaffoldKey: _scaffoldKey,
        addNewItem: (title) => _insertSource(sourceDao, title),
        labelText: "Source",
        child: FloatingActionButton(
          onPressed: null,
          child: const AddNewItem(),
        ),
      ),
      drawer: DrawerMenu(),
    );
  }

  Future<int> _insertSource(SourceDao sourceDao, String title) async =>
      await sourceDao.createSource(title);

  Widget _editBottomSheet(BuildContext context, SourceDao sourceDao,
          Source source, GlobalKey<ScaffoldState> scaffoldKey) =>
      CustomBottmSheetWithFormField(
        context: context,
        addNewItem: (title) => _updateSource(sourceDao, source, title),
        child: const EditItem(),
        labelText: "Source",
        scaffoldKey: scaffoldKey,
        initalValue: source.title,
      );

  Future _updateSource(
          SourceDao sourceDao, Source source, String title) async =>
      await sourceDao.updateSource(source.copyWith(title: title));
}

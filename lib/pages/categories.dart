import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selavify/models/app_database.dart';

import 'package:selavify/models/dao.dart';
import 'package:selavify/widgets/bottom_sheet_with_form_field.dart';
import 'package:selavify/widgets/card_item.dart';
import 'package:selavify/widgets/dismiss_item.dart';
import 'package:selavify/widgets/drawer_menu.dart';
import 'package:selavify/widgets/icon_widgets.dart';

class CategoryList extends StatelessWidget {
  static final String routeName = "/categoryList";
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final categoryDao = Provider.of<CategoryDao>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: StreamBuilder<List<Category>>(
        stream: categoryDao.watchCategories(),
        builder: (context, AsyncSnapshot<List<Category>> snapshot) {
          final data = snapshot.data ?? List();
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (listViewCtx, index) {
              final category = data[index];
              return DismissibleListItem(
                deleteHandler: () => categoryDao.deleteCategory(category.id),
                itemId: category.id,
                child: CartItem(
                  title: category.title,
                  editBottomSheet: _editBottomSheet(
                      listViewCtx, categoryDao, category, _scaffoldKey),
                  createdTimestamp: category.createdDate,
                ),
              );
              // return Dismissible(
              //   direction: DismissDirection.endToStart,
              //   background: Container(
              //     alignment: AlignmentDirectional.centerEnd,
              //     color: Colors.amber,
              //     child: Padding(
              //       padding: const EdgeInsets.only(right: 10.0),
              //       child: Icon(Icons.delete),
              //     ),
              //   ),
              //   onDismissed: (DismissDirection direction) {
              //     categoryDao.deleteCategory(category.id);
              //   },
              //   key: ValueKey(category.id),
              //   child: Card(
              //     elevation: 5,
              //     child: ListTile(
              //       leading: CircleAvatar(
              //         child: Text(
              //           category.title[0].toUpperCase(),
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       title: Text(category.title.toUpperCase()),
              //       trailing: _editBottomSheet(
              //           listViewCtx, categoryDao, category, _scaffoldKey),
              //     ),
              //   ),
              // );
            },
          );
        },
      ),
      floatingActionButton: CustomBottmSheetWithFormField(
        context: context,
        scaffoldKey: _scaffoldKey,
        addNewItem: (title) => _insertCategory(categoryDao, title),
        labelText: "Category",
        child: FloatingActionButton(
          onPressed: null,
          child: const AddNewItem(),
        ),
      ),
      drawer: DrawerMenu(),
    );
    // );
  }

  Widget _editBottomSheet(BuildContext context, CategoryDao categoryDao,
          Category category, GlobalKey<ScaffoldState> scaffoldKey) =>
      CustomBottmSheetWithFormField(
        context: context,
        addNewItem: (title) => _updateCategory(categoryDao, category, title),
        child: Icon(Icons.edit),
        labelText: "Categroy",
        scaffoldKey: scaffoldKey,
        initalValue: category.title,
      );

  Future<int> _insertCategory(CategoryDao categoryDao, String title) async =>
      await categoryDao.createCategory(title);

  Future _updateCategory(
          CategoryDao categoryDao, Category category, String title) async =>
      await categoryDao.updateCategory(category.copyWith(title: title));
}

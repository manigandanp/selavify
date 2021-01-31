import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selavify/pages/categories.dart';
import 'package:selavify/pages/dashboard_page.dart';
import 'package:selavify/pages/sources.dart';
import 'package:selavify/pages/transaction_type.dart';
import 'package:selavify/pages/transactions.dart';
import 'package:selavify/services/google_drive_service.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  Map<String, dynamic> initialValue = {
    "name": "Guest",
    "imageUrl": "https://via.placeholder.com/50x50",
    "email": "",
  };
  bool isSignedIn = false;
  @override
  void initState() {
    gSignIn.isSignedIn.then((value) => isSignedIn = value);
  }

  GoogleDriveFacade gSignIn = GoogleDriveFacade();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          if (isSignedIn)
            buildAccountDetailsHeader(
              details: initialValue,
              isSigendIn: false,
              signInHandler: gSignIn.signIn,
            )
          else
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildAccountDetailsHeader(
                    details: snapshot.data,
                    isSigendIn: true,
                    signInHandler: gSignIn.signOut,
                  );
                } else {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }
              },
              future: gSignIn.accountDetails(),
              // initialData: initialValue,
            ),
          ListTile(
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Dashboard.routeName),
            title: _styledText("Dashboard"),
            leading: _styledIcon(context, Icons.home_outlined),
          ),
          Divider(),
          ListTile(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(CategoryList.routeName),
            title: _styledText("Category"),
            leading: _styledIcon(context, Icons.category_outlined),
          ),
          Divider(),
          ListTile(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(SourceList.routeName),
            title: _styledText("Sources"),
            leading: _styledIcon(context, Icons.source_outlined),
          ),
          Divider(),
          ListTile(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(TransactionTypeList.routeName),
            title: _styledText("Transaction Types"),
            leading: _styledIcon(context, Icons.transform_outlined),
          ),
          Divider(),
          ListTile(
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(TransactionsList.routeName),
            title: _styledText("Transactions"),
            leading: _styledIcon(context, Icons.money_outlined),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget buildAccountDetailsHeader({
    @required Map<String, dynamic> details,
    @required bool isSigendIn,
    @required Function signInHandler,
  }) {
    return SingleChildScrollView(
      child: DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.network(details["imageUrl"]),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                Text(
                  details["name"],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  details["email"],
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                )
              ],
            ),
            buildSignInButton(signInHandler, isSigendIn)
          ],
        ),
      ),
    );
  }

  Widget buildSignInButton(Function signInHandler, bool isSignedIn) {
    return GestureDetector(
      child: Text(isSignedIn ? 'Sign Out' : 'Sign In',
          style: TextStyle(fontSize: 13)),
      onTap: signInHandler,
    );
  }

  Widget _styledText(title) => Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _styledIcon(BuildContext context, IconData icon) =>
      Icon(icon, color: Theme.of(context).primaryColor);

  Future<Map<String, dynamic>> getAccountDetails() async {
    Map<String, dynamic> details = await GoogleDriveFacade().accountDetails();
    return details;
  }
}

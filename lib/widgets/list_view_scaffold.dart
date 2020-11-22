import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget floatingActionButton;
  
  BaseScaffold({
    @required this.title,
    @required this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _body(),
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _body() => Center(
        child: Text("Base Scaffold"),
      );
}

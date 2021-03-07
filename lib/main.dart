import 'package:flutter/material.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HomePage",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: Container(
          child: Center(
            child: Text("Home Page"),
          ),
        ),
      ),
    );
  }
}

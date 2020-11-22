// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:selavify/services/db_service.dart';

// class TempPage extends StatefulWidget {
//   static final routeName = "/tempPage";
//   @override
//   _TempPageState createState() => _TempPageState();
// }

// class _TempPageState extends State<TempPage> {
//   Future<List<Map<String, dynamic>>> result;

//   @override
//   void initState() {
//     result = DBService.queryTransactions();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Temp Page")),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: result,
//         builder: (ctx, snapshot) {
//           if (snapshot.hasError)
//             return Center(
//               child: Text(snapshot.error),
//             );
//           else if (snapshot.hasData) {
//             print("hello");
//             print(snapshot.data);
//             return Center(
//               child: Text(snapshot.data[0].toString()),
//             );
//           } else
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//         },
//       ),
//     );
//   }
// }

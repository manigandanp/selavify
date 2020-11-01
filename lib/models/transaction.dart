import 'dart:convert';

import 'package:selavify/models/model.dart';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction extends Model {
  static final tableName = "selavifyTransaction";

  Transaction({
    this.id,
    this.transactionTitle,
    this.transactionAmount,
    this.transactionTimestamp,
    this.transactionTypeId,
    this.categoryId,
    this.transactionSourceId,
    this.createdTimestamp,
    this.updatedTimestamp,
  });

  String id;
  String transactionTitle;
  double transactionAmount;
  int transactionTimestamp;
  String transactionTypeId;
  String categoryId;
  String transactionSourceId;
  int createdTimestamp;
  int updatedTimestamp;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        transactionTitle: json["transactionTitle"],
        transactionAmount: json["transactionAmount"].toDouble(),
        transactionTimestamp: json["transactionTimestamp"],
        transactionTypeId: json["transactionTypeId"],
        categoryId: json["categoryId"],
        transactionSourceId: json["transactionSourceId"],
        createdTimestamp: json["createdTimestamp"],
        updatedTimestamp: json["updatedTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transactionTitle": transactionTitle,
        "transactionAmount": transactionAmount,
        "transactionTimestamp": transactionTimestamp,
        "transactionTypeId": transactionTypeId,
        "categoryId": categoryId,
        "transactionSourceId": transactionSourceId,
        "createdTimestamp": createdTimestamp,
        "updatedTimestamp": updatedTimestamp,
      };

  @override
  String toString() {
    return json.encode(toJson());
  }
}

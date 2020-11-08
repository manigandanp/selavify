import 'dart:convert';

import 'package:selavify/models/model.dart';

TransactionType transactionTypeFromJson(String str) =>
    TransactionType.fromJson(json.decode(str));

String transactionTypeToJson(TransactionType data) =>
    json.encode(data.toJson());

class TransactionType extends Model {
  static final tableName = "transactionType";
  TransactionType({
    this.id,
    this.title,
    this.createdTimestamp,
    this.updatedTimestamp,
  });

  String id;
  String title;
  int createdTimestamp;
  int updatedTimestamp;

  factory TransactionType.fromJson(Map<String, dynamic> json) =>
      TransactionType(
        id: json["id"],
        title: json["title"],
        createdTimestamp: json["createdTimestamp"],
        updatedTimestamp: json["updatedTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "createdTimestamp": createdTimestamp,
        "updatedTimestamp": updatedTimestamp,
      };
}

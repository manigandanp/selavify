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
    this.transactionType,
    this.createdTimestamp,
    this.updatedTimestamp,
  });

  String id;
  String transactionType;
  int createdTimestamp;
  int updatedTimestamp;

  factory TransactionType.fromJson(Map<String, dynamic> json) =>
      TransactionType(
        id: json["id"],
        transactionType: json["transactionType"],
        createdTimestamp: json["createdTimestamp"],
        updatedTimestamp: json["updatedTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transactionType": transactionType,
        "createdTimestamp": createdTimestamp,
        "updatedTimestamp": updatedTimestamp,
      };
}

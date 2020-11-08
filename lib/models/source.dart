import 'dart:convert';

import 'package:selavify/models/model.dart';

Source sourceFromJson(String str) => Source.fromJson(json.decode(str));

String sourceToJson(Source data) => json.encode(data.toJson());

class Source extends Model {
  static final tableName = "transactionSource";
  Source({
    this.id,
    this.title,
    this.createdTimestamp,
    this.updatedTimestamp,
  });

  String id;
  String title;
  int createdTimestamp;
  int updatedTimestamp;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
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

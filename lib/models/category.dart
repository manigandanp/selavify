import 'dart:convert';

import 'model.dart';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category extends Model {
  static final tableName = "category";

  Category({
    this.id,
    this.title,
    this.createdTimestamp,
    this.updatedTimestamp,
  });

  String id;
  String title;
  int createdTimestamp;
  int updatedTimestamp;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

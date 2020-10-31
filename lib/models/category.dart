import 'dart:convert';

import 'model.dart';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category extends Model {
    Category({
        this.id,
        this.category,
        this.createdTimestamp,
        this.updatedTimestamp,
    });

    String id;
    String category;
    int createdTimestamp;
    int updatedTimestamp;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        category: json["category"],
        createdTimestamp: json["createdTimestamp"],
        updatedTimestamp: json["updatedTimestamp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "createdTimestamp": createdTimestamp,
        "updatedTimestamp": updatedTimestamp,
    };
}

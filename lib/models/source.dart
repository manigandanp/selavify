import 'dart:convert';

import 'package:selavify/models/model.dart';

Source sourceFromJson(String str) => Source.fromJson(json.decode(str));

String sourceToJson(Source data) => json.encode(data.toJson());

class Source extends Model {
  Source({
    this.id,
    this.source,
    this.createdTimestamp,
    this.updatedTimestamp,
  });

  String id;
  String source;
  int createdTimestamp;
  int updatedTimestamp;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        source: json["source"],
        createdTimestamp: json["createdTimestamp"],
        updatedTimestamp: json["updatedTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "source": source,
        "createdTimestamp": createdTimestamp,
        "updatedTimestamp": updatedTimestamp,
      };
}

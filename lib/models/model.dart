import 'dart:convert';

abstract class Model {
  static String tableName;
  String id;
  String title;
  fromJson(json) {}
  toJson() {}

  @override
  String toString() {
    return json.encode(toJson());
  }
}

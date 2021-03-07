import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:selavify/auth/models/user_model.dart';

void main() {
  final userModel = UserModel(
      userName: "user name", email: "some email", avatarUrl: "some image url");

  final jsonMap = json.decode('''{
      "userName": "user name",
      "email": "some email",
      "avatarUrl": "some image url"
    }''');
  test("fromJson should return correct userModel", () {
    UserModel result = UserModel.fromJson(jsonMap);

    expect(result, userModel);
  });

  test("toJson should return correct jsonMap", () {
    Map<String, dynamic> result = userModel.toJson();
    expect(result, jsonMap);
  });
}

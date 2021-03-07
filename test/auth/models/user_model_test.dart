import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:selavify/auth/models/user_model.dart';

void main() {
  test("fromJson should return correct userModel", () {
    final strObj = '''{
      "userName": "user name",
      "email": "some email",
      "avatarUrl": "some image url"
    }''';

    UserModel result = UserModel.fromJson(json.decode(strObj));

    expect(result == UserModel(
            userName: "user name",
            email: "some email",
            avatarUrl: "some image url"), true);
  });
}

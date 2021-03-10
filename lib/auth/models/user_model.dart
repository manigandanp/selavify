import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:selavify/auth/consts.dart';
import 'package:selavify/auth/entities/user_entity.dart';

class UserModel extends User {
  UserModel({
    @required String userName,
    @required String email,
    @required String avatarUrl,
  }) : super(userName: userName, email: email, avatarUrl: avatarUrl);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json[USER_NAME],
      email: json[EMAIL],
      avatarUrl: json[AVATAR_URL],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }

  bool get isGusetUser => userName == GUESTUSER[USER_NAME];
}

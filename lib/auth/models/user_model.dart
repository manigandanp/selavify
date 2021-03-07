import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:selavify/auth/entities/user_entity.dart';

class UserModel extends User {
  UserModel({
    @required String userName,
    @required String email,
    @required String avatarUrl,
  }) : super(userName: userName, email: email, avatarUrl: avatarUrl);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }
}

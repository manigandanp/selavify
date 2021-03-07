import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String userName;
  final String email;
  final String avatarUrl;

  const User({
    @required this.userName,
    @required this.email,
    @required this.avatarUrl,
  });

  @override
  List<Object> get props => [userName, email, avatarUrl];

  @override
  bool get stringify => true;
}

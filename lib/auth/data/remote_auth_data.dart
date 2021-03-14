import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:selavify/auth/models/user_model.dart';
import 'package:selavify/common/exceptions.dart';

abstract class RemoteAuthData {
  Future<UserModel> signIn();
  Future<void> signOut();
}

class GoogleAuth implements RemoteAuthData {
  final GoogleSignIn googleSignIn;

  GoogleAuth({@required this.googleSignIn});

  @override
  Future<UserModel> signIn() async {
    GoogleSignInAccount account = await googleSignIn.signInSilently();
    account ??= await googleSignIn.signIn();
    try {
      return UserModel(
          userName: account.displayName,
          email: account.email,
          avatarUrl: account.photoUrl);
    } catch (_) {
      throw new UserModelConversionException();
    }
  }

  @override
  Future<void> signOut() async {
    return await googleSignIn.signOut();
  }
}

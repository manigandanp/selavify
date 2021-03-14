import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:selavify/auth/models/user_model.dart';

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
    return UserModel(
        userName: account.displayName,
        email: account.email,
        avatarUrl: account.photoUrl);
  }

  @override
  Future<void> signOut() async {
    return await googleSignIn.signOut();
  }
}

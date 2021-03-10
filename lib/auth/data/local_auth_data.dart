import 'package:selavify/auth/models/user_model.dart';

abstract class LocalAuthData {
  Future<UserModel> getUserDetails();
  Future<void> saveUserDetails();
  Future<void> deleteUserDetails();
}


class LocalAuthDataImpl implements LocalAuthData{
  @override
  Future<void> deleteUserDetails() {
    // TODO: implement deleteUserDetails
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getUserDetails() {
    // TODO: implement getUserDetails
    throw UnimplementedError();
  }

  @override
  Future<void> saveUserDetails() {
    // TODO: implement saveUserDetails
    throw UnimplementedError();
  }

}
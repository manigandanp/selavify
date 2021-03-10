import 'package:selavify/auth/models/user_model.dart';

abstract class RemoteAuthData {
  Future<UserModel> signIn();
  Future<void> signOut();
}

class RemoteAuthDateImpl implements RemoteAuthData {
  @override
  Future<UserModel> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

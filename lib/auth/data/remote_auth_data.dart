import 'package:selavify/auth/models/user_model.dart';
import 'package:selavify/common/network_info.dart';

abstract class RemoteAuthData {
  Future<UserModel> signIn();
  Future<void> signOut();
}

class GoogleAuth implements RemoteAuthData {
  final NetworkInfo _networkInfo;
  
  GoogleAuth(this._networkInfo);

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

import 'package:selavify/auth/consts.dart';
import 'package:selavify/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalAuthData {
  Future<UserModel> getUserDetails();
  Future<bool> saveUserDetails(UserModel user);
  Future<bool> deleteUserDetails();
}

class LocalAuthDataImpl implements LocalAuthData {
  final SharedPreferences _prefs;

  LocalAuthDataImpl(this._prefs);

  @override
  Future<bool> deleteUserDetails() async {
    return await _prefs.remove(USER_NAME) &&
        await _prefs.remove(EMAIL) &&
        await _prefs.remove(AVATAR_URL);
  }

  @override
  Future<UserModel> getUserDetails() async {
    final UserModel guestUser = UserModel.fromJson(GUESTUSER);

    final userName = _prefs.getString(USER_NAME);
    final email = _prefs.getString(EMAIL);
    final avatarUrl = _prefs.getString(AVATAR_URL);
    final UserModel signedInUser =
        UserModel(userName: userName, email: email, avatarUrl: avatarUrl);

    return Future.value(userName == null ? guestUser : signedInUser);
  }

  @override
  Future<bool> saveUserDetails(UserModel user) async {
    return await _prefs.setString(USER_NAME, user.userName) &&
        await _prefs.setString(EMAIL, user.email) &&
        await _prefs.setString(AVATAR_URL, user.avatarUrl);
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:selavify/auth/consts.dart';
import 'package:selavify/auth/data/local_auth_data.dart';
import 'package:selavify/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockPrefrences extends Mock implements SharedPreferences {}

main() {
  SharedPreferences mockPrefs;
  LocalAuthDataImpl localAuthData;
  final tUserModel = UserModel.fromJson({
    USER_NAME: "some signed in username",
    EMAIL: "some email",
    AVATAR_URL: "some image url"
  });

  test("should return singed in usermodel from local data store", () async {
    mockPrefs = MockPrefrences();
    localAuthData = LocalAuthDataImpl(mockPrefs);

    when(mockPrefs.getString(USER_NAME)).thenAnswer((_) => tUserModel.userName);
    when(mockPrefs.getString(EMAIL)).thenAnswer((_) => tUserModel.email);
    when(mockPrefs.getString(AVATAR_URL))
        .thenAnswer((_) => tUserModel.avatarUrl);

    final signedIn = await localAuthData.getUserDetails();
    expect(signedIn, tUserModel);
  });

  test(
      "should return guest usermodel from local data store if no user stored already",
      () async {
    mockPrefs = MockPrefrences();
    localAuthData = LocalAuthDataImpl(mockPrefs);

    final guestUser = await localAuthData.getUserDetails();

    expect(guestUser, UserModel.fromJson(GUESTUSER));
    expect(guestUser.isGusetUser, true);
  });

  test("should delete user details from local data store", () async {
    SharedPreferences.setMockInitialValues(tUserModel.toJson());
    mockPrefs = await SharedPreferences.getInstance();
    localAuthData = LocalAuthDataImpl(mockPrefs);

    final isUserDeleted = await localAuthData.deleteUserDetails();

    expect(isUserDeleted, true);
  });

  test("should save the given usermodel in local data store", () async {
    SharedPreferences.setMockInitialValues({});
    mockPrefs = await SharedPreferences.getInstance();
    localAuthData = LocalAuthDataImpl(mockPrefs);
    final isUserSaved = await localAuthData.saveUserDetails(tUserModel);

    expect(isUserSaved, true);
  });
}

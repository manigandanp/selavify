import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:selavify/auth/auth_impl.dart';
import 'package:selavify/auth/data/local_auth_data.dart';
import 'package:selavify/auth/data/remote_auth_data.dart';
import 'package:selavify/auth/models/user_model.dart';
import 'package:selavify/common/failure.dart';
import 'package:selavify/common/network_info.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockGoogleAuth extends Mock implements GoogleAuth {}

class MockLocalAuthData extends Mock implements LocalAuthDataImpl {}

main() {
  OAuthImpl authImpl;
  NetworkInfo networkInfo;
  GoogleAuth googleAuth;
  LocalAuthDataImpl localAuthData;

  final userModel =
      UserModel(userName: "userName", email: "email", avatarUrl: "avatarUrl");

  setUp(() {
    networkInfo = MockNetworkInfo();
    googleAuth = MockGoogleAuth();
    localAuthData = MockLocalAuthData();
    authImpl = OAuthImpl(networkInfo, googleAuth, localAuthData);
  });

  group("offline test", () {
    test("signin should return Networkfailure messgae", () async {
      when(networkInfo.isConnected()).thenAnswer((_) async => false);
      final result = await authImpl.signIn();
      expect(result.isLeft(), true);
    });

    test("signOut should return Networkfailure messgae", () async {
      when(networkInfo.isConnected()).thenAnswer((_) async => false);
      final result = await authImpl.signOut();
      expect(result.isLeft(), true);
    });

    test("getUserDetail should return local user details", () async {
      when(networkInfo.isConnected()).thenAnswer((_) async => false);
      when(localAuthData.getUserDetails()).thenAnswer((_) async => userModel);

      final result = await authImpl.getUserDetails();

      expect(result.isRight(), true);
      expect(result, Right(userModel));
    });
  });

  group("online test", () {
    test("signin should return user details", () async {
      when(networkInfo.isConnected()).thenAnswer((_) async => true);
      when(googleAuth.signIn()).thenAnswer((_) async => userModel);
      when(localAuthData.saveUserDetails(any)).thenAnswer((_) async => true);

      final result = await authImpl.signIn();

      verify(localAuthData.saveUserDetails(userModel));
      expect(result.isRight(), true);
      expect(result, Right(userModel));
    });

    test("signOut should return delete user locally and return true", () async {
      when(networkInfo.isConnected()).thenAnswer((_) async => true);
      when(googleAuth.signOut()).thenAnswer((_) async => true);
      when(localAuthData.deleteUserDetails()).thenAnswer((_) async => true);

      final result = await authImpl.signOut();

      verify(localAuthData.deleteUserDetails());
      expect(result.isRight(), true);
      expect(result, Right(true));
    });
  });
}

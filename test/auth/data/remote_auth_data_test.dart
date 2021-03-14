import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:selavify/auth/data/remote_auth_data.dart';
import 'package:selavify/common/exceptions.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

main() {
  GoogleAuth googleAuth;
  GoogleSignIn googleSignIn;

  setUp(() {
    googleSignIn = MockGoogleSignIn();
    googleAuth = GoogleAuth(googleSignIn: googleSignIn);
  });

  test("should thorw exception if signIn mehtod retrurn null", () async {
    expect(() async => await googleAuth.signIn(),
        throwsA(isA<UserModelConversionException>()));
  });
}

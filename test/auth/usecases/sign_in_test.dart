import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:selavify/auth/auth.dart';
import 'package:selavify/auth/usecases/sign_in.dart';
import 'package:selavify/common/no_params.dart';

import '../../mocks/mock_auth.dart';

void main() {
  OAuth auth;
  SignIn usecase;

  setUp(() {
    auth = MockAuth();
    usecase = SignIn(auth);
  });

  test("should log into the account", () async {
    when(auth.signIn()).thenAnswer((_) async => Right(true));
    final result = await usecase(NoParams());
    expect(result, Right(true));
    verify(auth.signIn());
    verifyNoMoreInteractions(auth);
  });
}

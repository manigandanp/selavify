import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:selavify/auth/auth.dart';
import 'package:selavify/auth/usecases/usecases.dart';
import 'package:selavify/common/no_params.dart';

import '../../mocks/mock_auth.dart';

main() {
  OAuth auth;
  SignOut usecase;

  setUp(() {
    auth = MockAuth();
    usecase = SignOut(auth);
  });
  test("should logout from the user account", () async {
    when(auth.signOut()).thenAnswer((_) async => Right(true));
    final result = await usecase(NoParams());

    expect(result, Right(true));
    verify(auth.signOut());
    verifyNoMoreInteractions(auth);
  });
}

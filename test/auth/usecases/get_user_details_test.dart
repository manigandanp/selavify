import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:selavify/auth/entities/user_entity.dart';
import 'package:selavify/auth/usecases/usecases.dart';
import 'package:selavify/common/no_params.dart';

import '../../mocks/mock_auth.dart';

main() {
  MockAuth auth;
  GetUserDetails usecase;

  setUp(() {
    auth = MockAuth();
    usecase = GetUserDetails(auth);
  });

  test("should retrun current user object", () async {
    final userObj = User("userName", "email", "avatarUrl");
    when(auth.getUserDetails()).thenAnswer((_) async => Right(userObj));

    final result = await usecase(NoParams());
    expect(result, Right(userObj));
    verify(auth.getUserDetails());
    verifyNoMoreInteractions(auth);
  });
}

import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../../common/no_params.dart';
import '../auth.dart';
import '../entities/user_entity.dart';
import 'auth_usecase.dart';

class SignIn implements Usecase<User, NoParams> {
  final OAuth auth;

  SignIn(this.auth);

  @override
  Future<Either<Failure, User>> call(NoParams noParams) async =>
      await auth.signIn();
}

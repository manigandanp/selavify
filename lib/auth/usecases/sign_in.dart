import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../../common/no_params.dart';
import '../auth.dart';
import 'auth_usecase.dart';

class SignIn implements Usecase<bool, NoParams> {
  final OAuth auth;

  SignIn(this.auth);

  @override
  Future<Either<Failure, bool>> call(NoParams noParams) async =>
      await auth.signIn();
}

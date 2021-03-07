import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../../common/no_params.dart';
import '../auth.dart';
import '../entities/user_entity.dart';
import 'auth_usecase.dart';

class GetUserDetails implements Usecase<User, NoParams> {
  final OAuth auth;

  GetUserDetails(this.auth);
  @override
  Future<Either<Failure, User>> call(noParams) async =>
      await auth.getUserDetails();
}

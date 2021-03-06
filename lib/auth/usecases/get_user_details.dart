import 'package:dartz/dartz.dart';
import 'package:selavify/common/no_params.dart';
import '../../entities/user_entity.dart';
import '../auth.dart';

import '../../common/failure.dart';
import 'auth_usecase.dart';

class GetUserDetails implements Usecase<User, NoParams> {
  final OAuth auth;

  GetUserDetails(this.auth);
  @override
  Future<Either<Failure, User>> call(noParams) async =>
      await auth.getUserDetails();
}

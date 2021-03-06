import 'package:dartz/dartz.dart';

import '../common/failure.dart';
import '../entities/user_entity.dart';

abstract class OAuth {
  Future<Either<Failure, bool>> signIn();
  Future<Either<Failure, bool>> signOut();
  Future<Either<Failure, User>> getUserDetails();
}

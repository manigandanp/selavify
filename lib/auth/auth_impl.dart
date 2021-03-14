import 'package:dartz/dartz.dart';
import 'package:selavify/auth/auth.dart';
import 'package:selavify/auth/data/local_auth_data.dart';
import 'package:selavify/auth/data/remote_auth_data.dart';
import 'package:selavify/common/exceptions.dart';
import 'package:selavify/common/failure.dart';
import 'package:selavify/common/network_info.dart';

import 'entities/user_entity.dart';
import 'models/user_model.dart';

class OAuthImpl implements OAuth {
  final NetworkInfo networkInfo;
  final GoogleAuth googleAuth;
  final LocalAuthData localAuthData;

  OAuthImpl(this.networkInfo, this.googleAuth, this.localAuthData);

  @override
  Future<Either<Failure, User>> getUserDetails() async {
    try {
      return Right(await localAuthData.getUserDetails());
    } catch (ex) {
      return Left(LocalDataFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signIn() async {
    try {
      UserModel user = await googleAuth.signIn();
      await localAuthData.saveUserDetails(user);
      return Right(user);
    } on UserModelConversionException {
      final String className = this.runtimeType.toString();
      return Left(UserModelConversionFailure(className: className));
    } catch (ex) {
      return Left(RemoteAuthFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      await googleAuth.signOut();
      await localAuthData.deleteUserDetails();
      return Right(true);
    } catch (ex) {
      return Left(RemoteAuthFailure(ex.toString()));
    }
  }
}

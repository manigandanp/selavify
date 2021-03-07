import 'package:dartz/dartz.dart';
import 'package:selavify/auth/auth.dart';
import 'package:selavify/common/failure.dart';

import 'entities/user_entity.dart';

class GoogleAuth implements OAuth {
  @override
  Future<Either<Failure, User>> getUserDetails() {
    //if signed in
    // first time
    //  retrive user detail from remote
    // store retrived user  detail from local
    // after that
    // retrive user detail from local
    // fail to retrive user both from local and remote return Guest User

    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signIn() {
    // sign in to the account
    // store the user data to local db
    // send failure message if already signed in
    // send failure message if there is network issue
    // send failure message if user cancels sign in process
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> signOut() {
    // sign out from the account
    // delete user from local db
    // send failure message if not signed in
    // send failure message if there is network issue
    // send failure message if user cancels process
    throw UnimplementedError();
  }
}

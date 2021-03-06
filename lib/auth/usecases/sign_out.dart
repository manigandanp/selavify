import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../../common/no_params.dart';
import '../auth.dart';
import 'auth_usecase.dart';

class SignOut implements Usecase<bool, NoParams> {
  final OAuth auth;

  SignOut(this.auth);
  //TODO: https://youtu.be/Mmq72a0h4jk?list=PLB6lc7nQ1n4iYGE_khpXRdJkJEp9WOech&t=493

  @override
  Future<Either<Failure, bool>> call(noParams) async => await auth.signOut();
}

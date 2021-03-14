import 'package:flutter/foundation.dart';

class Failure {
  final String message;
  Failure(this.message);
  @override
  String toString() => message;
}

class LocalDataFailure extends Failure {
  LocalDataFailure(String message) : super(message);
}

class RemoteAuthFailure extends Failure {
  RemoteAuthFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  final String message =
      "No Internet connection. Please check your connection and try again";
  NetworkFailure({message}) : super(message);
}

class UserModelConversionFailure extends Failure {
  final String messgae = " - Failed to convert user model";
  final String className;
  UserModelConversionFailure({@required this.className, message})
      : super("[$className] $message ");
}

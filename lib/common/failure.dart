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
  NetworkFailure(String message) : super(message);
}

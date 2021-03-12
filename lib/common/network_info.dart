abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> isConnected() async {
    ConnectivityResult connection = await _connectivity.checkConnectivity();
    return connection != ConnectivityResult.none;
  }
}

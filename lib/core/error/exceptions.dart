class ServerException implements Exception {
  String msg;

  ServerException(this.msg);
}

class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'Network Exception'});

  @override
  String toString() {
    return 'NetworkException: $message';
  }
}

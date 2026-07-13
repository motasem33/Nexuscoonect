class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends ApiException {
  NetworkException() : super('No internet connection. Please check your network.');
}

class ServerException extends ApiException {
  ServerException() : super('Server error occurred. Please try again later.');
}

class NotFoundException extends ApiException {
  NotFoundException() : super('The requested resource was not found.');
}

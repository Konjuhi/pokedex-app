sealed class AppException implements Exception {
  AppException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException([String message = 'No internet connection'])
    : super('network_error', message);
}

class UnknownException extends AppException {
  UnknownException([String message = 'Something went wrong'])
    : super('unknown_error', message);
}

class AuthException extends AppException {
  AuthException(String message) : super('auth_error', message);
}

class ApiException extends AppException {
  ApiException(String message) : super('api_error', message);
}

class DbException extends AppException {
  DbException(String message) : super('database_error', message);
} 
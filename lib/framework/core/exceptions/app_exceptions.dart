// ignore_for_file: prefer_typing_uninitialized_variables

class AppException implements Exception {
  const AppException([
    this.message,
    this._prefix = '',
  ]);

  final dynamic message;
  final String? _prefix;

  @override
  String toString() {
    return "$_prefix$message";
  }
}

class NetworkException extends AppException {
  NetworkException() : super('Koneksi internet anda terputus mohon coba lagi');
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Terdapat kesalahan dalam proses: ");
}

class BadRequestException extends AppException {
  BadRequestException([super.message]);
}

class NotAcceptableException extends AppException {
  NotAcceptableException([super.message]);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([super.message]);
}

class NotFoundException extends AppException {
  NotFoundException([super.message]);
}

class MissingParamsException extends AppException {
  MissingParamsException()
      : super("Ada beberapa parameter yang hilang, periksa parameter");
}

class InvalidCredentialException extends AppException {
  InvalidCredentialException([super.message]);
}

class ServerException extends AppException {
  ServerException([super.message]);
}

class CacheException implements Exception {}

import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final String? message;
  final String prefix;

  const AppException(this.message, this.prefix);

  @override
  String toString() {
    return "$prefix${message ?? '發生未預期的錯誤，請稍後重試'}";
  }

  String get errorMessage {
    if (message != null) return toString();
    return message ?? prefix + '發生未預期的錯誤，請稍後重試';
  }

  @override
  List<Object> get props => [];
}

class FetchDataException extends AppException {
  const FetchDataException({String? message})
      : super(
          message,
          "Error During Communication: ",
        );
}

class BadRequestException extends AppException {
  const BadRequestException({String? message})
      : super(
          message,
          "Bad Request: ",
        );
}

class RequestTimeOutException extends AppException {
  const RequestTimeOutException({String? message})
      : super(
          message,
          "Request Time out: ",
        );
}

class BadDataException extends AppException {
  const BadDataException(
    String? message,
  ) : super(
          message,
          'BadDataException: ',
        );
}

class ValidateException extends AppException {
  const ValidateException({required String message})
      : super(
          message,
          "Validate Failed: ",
        );
}

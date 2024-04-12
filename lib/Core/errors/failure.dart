// Abstract classes can't be instantiated.
import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          message: 'Connection timeout with the server',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          message: 'Send timeout with the server',
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          message: 'Receive timeout in connection with the server',
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          message: 'Invalid certificate for the server',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode!,
          e.response!,
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          message: 'Request cancelled by the client',
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          message: 'No internet connection',
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          message: 'Oops! Something went wrong, please try again later',
        );
    }
  }

  factory ServerFailure.fromResponse(int statusCode, Response response) {
    switch (statusCode) {
      // 400, 401, 403 are changeable based on the API you are using.
      case 400:
        return ServerFailure(
          message: '${response.data['error']['message']}',
        );
      case 401:
        return ServerFailure(
          message: '${response.data['error']['message']}',
        );
      case 403:
        return ServerFailure(
          message: '${response.data['error']['message']}',
        );
      case 404:
        return ServerFailure(
          message: 'Your request was not found, please try again later',
        );
      case 500:
        return ServerFailure(
          message: 'There is an error in the server, please try again later',
        );
      case 503:
        return ServerFailure(
          message: 'Service unavailable',
        );
      default:
        return ServerFailure(
          message: 'Oops! Something went wrong, please try again later',
        );
    }
  }
}

// TODO: Add more failures
// class CacheFailure extends Failure {}
// class NetworkFailure extends Failure {}

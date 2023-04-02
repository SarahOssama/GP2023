import 'package:audima/data/network/failure.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      //dio error so it is error from response of the API or dio itself

      switch (error.type) {
        case DioErrorType.cancel:
          failure = DataSource.CANCEL.getFailure();
          break;
        case DioErrorType.connectionTimeout:
          failure = DataSource.CONNECT_TIMEOUT.getFailure();
          break;
        case DioErrorType.receiveTimeout:
          failure = DataSource.RECEIVE_TIMEOUT.getFailure();
          break;
        case DioErrorType.sendTimeout:
          failure = DataSource.SEND_TIMEOUT.getFailure();
          break;
        case DioErrorType
            .unknown: //this one means that api itself returned to me error with a specific status code and message
          if (error.response != null &&
              error.response?.statusCode != null &&
              error.response?.statusMessage != null) {
            failure = Failure(error.response?.statusCode ?? 0,
                error.response?.statusMessage ?? "");
            break;
          }
          failure = DataSource.DEFAULT.getFailure();
          break;

        case DioErrorType.badCertificate:
          failure = DataSource.DEFAULT.getFailure();

          break;
        case DioErrorType.connectionError:
          failure = DataSource.DEFAULT.getFailure();
          break;
        case DioErrorType.badResponse:
          failure = DataSource.DEFAULT.getFailure();
          break;
      }
    } else {
      //default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  RECEIVE_TIMEOUT,
  CANCEL,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERENT_CONNECTION,
  DEFAULT
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERENT_CONNECTION:
        return Failure(ResponseCode.NO_INTERENT_CONNECTION,
            ResponseMessage.NO_INTERENT_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 204;
  static const int BAD_REQUEST = 400;
  static const int FORBIDDEN = 403;
  static const int UNAUTHORIZED = 401;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int CONNECT_TIMEOUT = 1001;
  static const int RECEIVE_TIMEOUT = 1002;
  static const int CANCEL = 1003;
  static const int SEND_TIMEOUT = 1004;
  static const int CACHE_ERROR = 1005;
  static const int NO_INTERENT_CONNECTION = 1006;
  static const int DEFAULT = 1007;
}

class ResponseMessage {
  static const String SUCCESS = "Success";
  static const String NO_CONTENT = "Success with no Content";
  static const String BAD_REQUEST = "Bad Request";
  static const String FORBIDDEN = "Forbidden";
  static const String UNAUTHORIZED = "Unauthorized";
  static const String NOT_FOUND = "Not Found";
  static const String INTERNAL_SERVER_ERROR = "Internal Server Error";
  static const String CONNECT_TIMEOUT = "Connect Timeout";
  static const String RECEIVE_TIMEOUT = "Receive Timeout";
  static const String CANCEL = "Cancel";
  static const String SEND_TIMEOUT = "Send Timeout";
  static const String CACHE_ERROR = "Cache Error";
  static const String NO_INTERENT_CONNECTION = "No Internet Connection";
  static const String DEFAULT = "DEFAULT Error";
}

class APIInternalStatus {
  static const int SUCESS = 0;
  static const int FAIULRE = 1;
}

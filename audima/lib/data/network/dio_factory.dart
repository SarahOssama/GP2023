import 'package:audima/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "Content-Type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      DEFAULT_LANGUAGE:
          Constants.defaultLanguage, //TODO get lang from app prefrences
      AUTHORIZATION: Constants.token,
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: Constants.apiTimeout,
      sendTimeout: Constants.apiTimeout,
    );

    if (!kReleaseMode) {
      //it is debug log so print app logs
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, responseHeader: true, requestBody: true));
    }
    return dio;
  }
}

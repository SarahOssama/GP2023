import 'package:audima/app/app_prefrences.dart';
import 'package:audima/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "Content-Type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";
const String API_KEY = "x-api-key";

class DioFactory {
  final AppPreferences _appPrefrences;
  DioFactory(this._appPrefrences);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    String language = await _appPrefrences.getAppLanguage();
    // Map<String, String> headers = {
    //   CONTENT_TYPE: APPLICATION_JSON,
    //   API_KEY: Constants.missionStatementApiKey,
    //   // ACCEPT: APPLICATION_JSON,
    //   // DEFAULT_LANGUAGE: language, //TODO get lang from app prefrences
    //   // AUTHORIZATION: Constants.token,
    // };
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      // headers: headers,
    );

    if (!kReleaseMode) {
      //it is debug log so print app logs

      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, responseHeader: true, requestBody: true));
    }
    return dio;
  }
}

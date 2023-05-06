import 'dart:io'; 
import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:audima/app/constants.dart';
import 'package:audima/data/response/responses.dart';
import 'dio_factory.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  //login Api
  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );

  //businessInfoApi
  @POST("/blog-post-generation")
  Future<MissionStatementResponse> getMissionStatement(
    @Field("text") String businessInfoStatement,
  );
}
@RestApi(baseUrl: Constants.videoManipulationUrl)
abstract class VideoServiceClient {
  factory VideoServiceClient(Dio dio, {String baseUrl}) = _VideoServiceClient;
  //upload video api
  @POST("/video/upload/")
  @MultiPart()
  Future<VideoResponse> uploadVideo(
      @Part(name: 'media_file') File file,
      @Part(name: 'caption') String caption,
  );

 
}

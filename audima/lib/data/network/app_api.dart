import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:audima/app/constants.dart';
import 'package:audima/data/response/responses.dart';

import 'dio_factory.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl2)
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

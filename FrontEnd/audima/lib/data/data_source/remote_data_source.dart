//the idea behind remote data source is to talk to the api inside the network layer in the data layer
//so we need to talk with app service client in the network layer
import 'dart:async';

import 'package:audima/data/network/app_api.dart';
import 'package:audima/data/network/requests.dart';
import 'package:audima/data/response/responses.dart';

abstract class RemoteDataSource {
  //the difference between the functions here and the functions in the repository inside the domain layer is that
  //the functions here will return the response directly from the api inside the data layer
  //while the functions in the repository inside the domain layer will return a model object
  //so the functions here will return a future of the responses not the model objects
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  //business info
  Future<MissionStatementResponse> getMissionStatement(
      BusinessInfoRequest businessInfoRequest);
  //video
  Future<VideoResponse> uploadVideo(UploadVideoRequest videoRequest);
  //edit video
  Future<VideoResponse> editVideo(EditVideoRequest editVideoRequest);
  Future<ConfirmEditResponse> preEditVideo(
      PreEditVideoRequest preEditVideoRequest);
}

//create the class which implements the remote data source abstract class
class RemoteDataSourceImpl implements RemoteDataSource {
  //here I need instance from the appserviceclient
  //so i need to inject it inside the constructor
  //so i need to create a constructor
  //then i need to create an instance from the appserviceclient
  final AppServiceClient _appServiceClient;
  final VideoServiceClient _videoServiceClient;
  RemoteDataSourceImpl(this._appServiceClient, this._videoServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    //here i need to call the login function from the appserviceclient
    //but i need to pass the email and password to the login function
    //so i need to create a login request object
    //then i need to pass the email and password to the login request object
    //then i need to pass the login request object to the login function
    //then i need to return the response from the login function
    //so i need to create a login request object
    // LoginRequest loginRequest = LoginRequest(email, password);
    //then i need to pass the email and password to the login request object
    //then i need to pass the login request object to the login function
    //then i need to return the response from the login function
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<MissionStatementResponse> getMissionStatement(
      BusinessInfoRequest businessInfoRequest) async {
    return await _appServiceClient
        .getMissionStatement(businessInfoRequest.bussinesInfoTextElements);
  }

  @override
  Future<VideoResponse> uploadVideo(UploadVideoRequest videoRequest) {
    return _videoServiceClient.uploadVideo(
        videoRequest.file, videoRequest.caption);
  }

  @override
  Future<VideoResponse> editVideo(EditVideoRequest editVideoRequest) {
    return _videoServiceClient.editVideo(editVideoRequest.command);
  }

  @override
  Future<ConfirmEditResponse> preEditVideo(
      PreEditVideoRequest preEditVideoRequest) {
    return _videoServiceClient.preEditVideo(preEditVideoRequest.command);
  }
}

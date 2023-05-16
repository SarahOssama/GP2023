import 'package:audima/data/network/failure.dart';
import 'package:audima/data/network/requests.dart';
import 'package:audima/domain/model/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  //the return type of every requests in the domain layer won't be in the form of response as response in the data layer should be converted to a model in domain layer
  //but also i won't be using a model object to be the return of the requests as for example login might return an error
  //so i will be using a an Either object that will be either a success or a failure(left->error , right->sucess)
  //so left is , while right is the model object
  //login in api call inside data layer is future so this login request inside domain layer must be future too
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  //so lastly it is like an example for the process will be done which is
  //1- data which user input will come from our view model
  //2- view model will pass the data to the repository
  //3- then the repo will pass this data to the network layer to fire the request from network layer to the back end
  //4- then the response will come from the back end to the network layer
  //5- then the network layer will convert the response to a model object
  //6- then the model object will be returned to the repository
  //7- then the repository will return the model object to the view model
  //8- then the view model will return the model object to the view

  Future<Either<Failure, MissionStatement>> getMissionStatement(
      BusinessInfoRequest businessInfoRequest);

  //upload video
  Future<Either<Failure, Video>> uploadVideo(UploadVideoRequest videoRequest);

  //edit video
  Future<Either<Failure, Video>> editVideo(EditVideoRequest editVideoRequest);
  //pre edit video
  Future<Either<Failure, ConfirmEdit>> preEditVideo(
      PreEditVideoRequest preEditVideoRequest);
}

import 'package:audima/data/data_source/remote_data_source.dart';
import 'package:audima/data/mapper/mapper.dart';
import 'package:audima/data/network/error_handler.dart';
import 'package:audima/data/network/network_info.dart';
import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:audima/domain/model/models.dart';

import 'package:audima/data/network/requests.dart';

import 'package:audima/data/network/failure.dart';

import '../../domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  //this is full process of the login api call which will return to the view model
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    //story of this full process of this api login
    //1- i need to check if the user is connected to internet or not
    //delw2ty ana bashof law hwa not connected to internet ana barag3 failure object wel mafrod yb2a feha 7agten 1- status code and 2- el message which implemented in error handler.dart file
    //law b2a el internet is connected bn use try and catch
    //then bashof law el response galy men el data layer login function el bastkhdmha men el instance of remote data source
    //law 7asal ay error gher el internal errors el el backend developer hatethomly fel api request baro7 ashof men el error handler file w arg3 el corrosponding failure object
    //law kolo tamam bashof el api status code men el fel api bta3t el backend engineer law hya success so barag3 el response bas ba7wlo leh model 3lshan yrg3 lel view model
    // law 7asal failure zay mah el backend developer 7atetholy barag3 el default message
    if (await _networkInfo.isConnected) {
      //it is connected to interent so it is safe to call the api
      //so i need to call the login function from the remote data source

      try {
        final response = await _remoteDataSource.login(loginRequest);

        //then i need to check if the response is success or failure
        if (response.status == APIInternalStatus.SUCESS) {
          //it is success so i need to return a success
          //return the data
          return Right(response.toDomain());
        } else {
          //it is unknown so i need to return a failure
          return Left(Failure(APIInternalStatus.FAIULRE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //it is not connected to internet so it is not safe to call the api
      //so i need to return a failure
      return Left(DataSource.NO_INTERENT_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, MissionStatement>> getMissionStatement(
      BusinessInfoRequest businessInfoRequest) async {
    if (await _networkInfo.isConnected) {
      //it is connected to interent so it is safe to call the api
      //so i need to call the login function from the remote data source
      try {
        final response =
            await _remoteDataSource.getMissionStatement(businessInfoRequest);

        //then i need to check if the response is success or failure
        if (response.missionStatement != null) {
          //it is success so i need to return a success
          //return the data
          return Right(response.toDomain());
        } else {
          //it is unknown so i need to return a failure
          return Left(Failure(APIInternalStatus.FAIULRE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //it is not connected to internet so it is not safe to call the api
      //so i need to return a failure
      return Left(DataSource.NO_INTERENT_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Video>> uploadVideo(
      UploadVideoRequest videoRequest) async {
    // final connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   print("mobile");
    //   // I am connected to a mobile network.
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   print("wifi");
    //   // I am connected to a wifi network.
    // }
    if (await _networkInfo.isConnected) {
      //it is connected to interent so it is safe to call the api
      //so i need to call the login function from the remote data source
      try {
        final response = await _remoteDataSource.uploadVideo(videoRequest);

        //then i need to check if the response is success or failure
        if (response.message == "uploaded") {
          //it is success so i need to return a success
          //return the data
          return Right(response.toDomain());
        } else {
          //it is unknown so i need to return a failure
          return Left(Failure(APIInternalStatus.FAIULRE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //it is not connected to internet so it is not safe to call the api
      //so i need to return a failure
      return Left(DataSource.NO_INTERENT_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Video>> editVideo(
      EditVideoRequest editVideoRequest) async {
    if (await _networkInfo.isConnected) {
      //it is connected to interent so it is safe to call the api
      //so i need to call the login function from the remote data source
      try {
        final response = await _remoteDataSource.editVideo(editVideoRequest);

        //then i need to check if the response is success or failure
        if (response.videoPath != null) {
          //it is success so i need to return a success
          //return the data
          return Right(response.toDomain());
        } else {
          //it is unknown so i need to return a failure
          return Left(Failure(APIInternalStatus.FAIULRE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //it is not connected to internet so it is not safe to call the api
      //so i need to return a failure
      return Left(DataSource.NO_INTERENT_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ConfirmEdit>> preEditVideo(
      PreEditVideoRequest preEditVideoRequest) async {
    if (await _networkInfo.isConnected) {
      //it is connected to interent so it is safe to call the api
      //so i need to call the login function from the remote data source
      try {
        final response =
            await _remoteDataSource.preEditVideo(preEditVideoRequest);

        //then i need to check if the response is success or failure
        if (response.status == APIInternalStatus.SUCESS) {
          //it is success so i need to return a success
          //return the data
          return Right(response.toDomain());
        } else {
          //it is unknown so i need to return a failure
          return Left(Failure(APIInternalStatus.FAIULRE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //it is not connected to internet so it is not safe to call the api
      //so i need to return a failure
      return Left(DataSource.NO_INTERENT_CONNECTION.getFailure());
    }
  }
}

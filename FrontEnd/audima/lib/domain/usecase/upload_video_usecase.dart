import 'dart:io';

import 'package:audima/data/network/failure.dart';
import 'package:audima/data/network/requests.dart';
import 'package:audima/domain/model/models.dart';
import 'package:audima/domain/repository/repository.dart';
import 'package:audima/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class UploadVideoUseCase
    implements
        BaseUseCase<UploadVideoUseCaseInput, Video> {
  final Repository _repository;
  UploadVideoUseCase(this._repository);
  @override
  Future<Either<Failure, Video>> execute(
      UploadVideoUseCaseInput input) async {
    return await _repository
        .uploadVideo(UploadVideoRequest(input.video, input.caption));
  }
}

class UploadVideoUseCaseInput {
  File video;
  String caption;

  UploadVideoUseCaseInput(this.video, this.caption);
}

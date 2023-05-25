import 'dart:io';

import 'package:audima/data/network/failure.dart';
import 'package:audima/data/network/requests.dart';
import 'package:audima/domain/model/models.dart';
import 'package:audima/domain/repository/repository.dart';
import 'package:audima/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class PreEditInsertVideoUseCase
    implements BaseUseCase<PreEditInsertVideoUseCaseInput, ConfirmEdit> {
  final Repository _repository;
  PreEditInsertVideoUseCase(this._repository);
  @override
  Future<Either<Failure, ConfirmEdit>> execute(
      PreEditInsertVideoUseCaseInput input) async {
    return await _repository.preEditInsertVideo(
        PreEditInsertVideoRequest(input.command, input.file));
  }
}

class PreEditInsertVideoUseCaseInput {
  String command;
  File file;

  PreEditInsertVideoUseCaseInput(this.command, this.file);
}

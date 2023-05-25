import 'package:audima/data/network/failure.dart';
import 'package:audima/data/network/requests.dart';
import 'package:audima/domain/model/models.dart';
import 'package:audima/domain/repository/repository.dart';
import 'package:audima/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class PreEditVideoUseCase
    implements BaseUseCase<PreEditVideoUseCaseInput, ConfirmEdit> {
  final Repository _repository;
  PreEditVideoUseCase(this._repository);
  @override
  Future<Either<Failure, ConfirmEdit>> execute(
      PreEditVideoUseCaseInput input) async {
    return await _repository.preEditVideo(PreEditVideoRequest(input.command));
  }
}

class PreEditVideoUseCaseInput {
  String command;

  PreEditVideoUseCaseInput(this.command);
}

import 'package:audima/data/network/failure.dart';
import 'package:audima/data/network/requests.dart';
import 'package:audima/domain/model/models.dart';
import 'package:audima/domain/repository/repository.dart';
import 'package:audima/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class EditVideoUseCase implements BaseUseCase<EditVideoUseCaseInput, Video> {
  final Repository _repository;
  EditVideoUseCase(this._repository);
  @override
  Future<Either<Failure, Video>> execute(EditVideoUseCaseInput input) async {
    return await _repository.editVideo(EditVideoRequest(input.command));
  }
}

class EditVideoUseCaseInput {
  String command;

  EditVideoUseCaseInput(this.command);
}

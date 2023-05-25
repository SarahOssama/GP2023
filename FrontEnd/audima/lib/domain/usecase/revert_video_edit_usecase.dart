import 'package:audima/data/network/failure.dart';
import 'package:audima/data/network/requests.dart';
import 'package:audima/domain/model/models.dart';
import 'package:audima/domain/repository/repository.dart';
import 'package:audima/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RevertVideoEditUseCase
    implements BaseUseCase<RevertVideoEditUseCaseInput, Video> {
  final Repository _repository;
  RevertVideoEditUseCase(this._repository);
  @override
  Future<Either<Failure, Video>> execute(
      RevertVideoEditUseCaseInput input) async {
    return await _repository.revertVideoEdit();
  }
}

class RevertVideoEditUseCaseInput {}

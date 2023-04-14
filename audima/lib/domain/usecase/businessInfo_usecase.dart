import 'package:audima/data/network/failure.dart';
import 'package:audima/data/network/requests.dart';
import 'package:audima/domain/model/models.dart';
import 'package:audima/domain/repository/repository.dart';
import 'package:audima/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class MissionStatementUseCase
    implements
        BaseUseCase<MissionStatementUseCaseUseCaseInput, MissionStatement> {
  final Repository _repository;
  MissionStatementUseCase(this._repository);
  @override
  Future<Either<Failure, MissionStatement>> execute(
      MissionStatementUseCaseUseCaseInput input) async {
    return await _repository
        .getMissionStatement(BusinessInfoRequest(input.businessInfoStatement));
  }
}

class MissionStatementUseCaseUseCaseInput {
  String businessInfoStatement;

  MissionStatementUseCaseUseCaseInput(this.businessInfoStatement);
}

import 'package:audima/data/network/failure.dart';
import 'package:audima/data/network/requests.dart';
import 'package:audima/domain/model/models.dart';
import 'package:audima/domain/repository/repository.dart';
import 'package:audima/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class MissionStatementUseCase
    implements
        BaseUseCase<MissionStatementUseCaseInput, MissionStatement> {
  final Repository _repository;
  MissionStatementUseCase(this._repository);
  @override
  Future<Either<Failure, MissionStatement>> execute(
      MissionStatementUseCaseInput input) async {
    return await _repository
        .getMissionStatement(BusinessInfoRequest(input.businessInfoStatement));
  }
}

class MissionStatementUseCaseInput {
  String businessInfoStatement;

  MissionStatementUseCaseInput(this.businessInfoStatement);
}

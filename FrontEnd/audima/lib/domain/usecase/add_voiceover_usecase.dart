import 'package:audima/data/network/failure.dart';
import 'package:audima/data/network/requests.dart';
import 'package:audima/domain/model/models.dart';
import 'package:audima/domain/repository/repository.dart';
import 'package:audima/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class AddVoiceOverUseCase
    implements BaseUseCase<AddVoiceOverUseCaseInput, Video> {
  final Repository _repository;
  AddVoiceOverUseCase(this._repository);
  @override
  Future<Either<Failure, Video>> execute(AddVoiceOverUseCaseInput input) async {
    return await _repository.addVoiceOver(AddVoiceOverRequest(input.choice));
  }
}

class AddVoiceOverUseCaseInput {
  int choice;
  AddVoiceOverUseCaseInput(this.choice);
}

import 'package:audima/data/network/failure.dart';
import 'package:audima/data/network/requests.dart';
import 'package:audima/domain/model/models.dart';
import 'package:audima/domain/repository/repository.dart';
import 'package:audima/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);
  //an example for the login full process
  //1- data which user input will come from our view model(like the user will enter the username and password)
  //2-this execute function will be called from our viewmodel and its input is the login info
  //3- then the repo will pass this data to the network layer to fire the request from network layer to the back end
  //4- then the response will come from the back end to the network layer
  //5- then the network layer will convert the response to a model object
  //6- then the model object will be returned to the repository
  //7- then the repository will return the model object to the view model
  //8- then the view model will return the model object to the view
  //-------------------------------------------------------------------------------------------------------------------
  //down here is the path of api execution
  //usecase_execute->domain/repo_apicall->data/repo_apicall->remotedatasource_apicall->apiserviceclient_apicall-> as a recursion then back until usecase exeucte has the output to give it to the view model
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}

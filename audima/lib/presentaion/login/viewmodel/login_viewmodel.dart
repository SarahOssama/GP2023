import 'dart:async';

import 'package:audima/domain/usecase/login_usecase.dart';
import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  //stream controllers outputs
  //brodcast made my stream controller has many listeners
  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  // final LoginUseCase _loginUseCase;

  LoginViewModel();

  //inputs
  @override
  void dispose() {
    _passwordStreamController.close();
    _usernameStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {}

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  void login() async {
    // (await _loginUseCase.execute(
    //         LoginUseCaseInput(loginObject.username, loginObject.password)))
    //     .fold(
    //         (failure) => {
    //               //left means failure
    //               print(failure.message)
    //             },
    //         (data) => {
    //               //right means success
    //               print(data.customer?.name)
    //             });
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    inputAreAllInputsValid.add(null);
    loginObject = loginObject.copyWith(password: password);
  }

  @override
  void setUsername(String userName) {
    inputUsername.add(userName);
    inputAreAllInputsValid.add(null);
    loginObject = loginObject.copyWith(username: userName);
  }

  //outputs
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUsernameValid => _usernameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  //private functions
  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isUsernameValid(loginObject.username) &&
        _isPasswordValid(loginObject.password);
  }
}

//inputs means the orders that our viewmodel will recieve from the view
abstract class LoginViewModelInputs {
  void setUsername(String userName);
  void setPassword(String password);
  void login();

  //stream controller input
  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  //stream controller output
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputAreAllInputsValid;
}

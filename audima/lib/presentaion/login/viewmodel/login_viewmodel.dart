import 'dart:async';

import 'package:audima/domain/usecase/login_usecase.dart';
import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:flutter/widgets.dart';

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
  final StreamController isUserLoggedInSuccessStreamController =
      StreamController<bool>();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  //inputs
  @override
  void dispose() {
    super.dispose();
    isUserLoggedInSuccessStreamController.close();
    _passwordStreamController.close();
    _usernameStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    //view model should ask the view to show the content state as no api is called when the login view is created
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  void login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.username, loginObject.password)))
        .fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popUpErrorState, failure.message));
      //left means failure
      print(failure.message);
    }, (data) {
      //right means success
      // inputState.add(ContentState());
      isUserLoggedInSuccessStreamController.add(true);
    });
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

_isCurrentDialogShowing(BuildContext context) {
  return ModalRoute.of(context)?.isCurrent != true;
}

dismissDialog(BuildContext context) {
  if (_isCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

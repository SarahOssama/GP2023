import 'dart:async';

import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  //shared variables and functions that will be used by any view model
  final StreamController inputStartStreamController =
      StreamController<FlowState>.broadcast();
  @override
  void dispose() {
    inputStartStreamController.close();
  }

  @override
  Sink get inputState => inputStartStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      inputStartStreamController.stream.map((flowstate) => flowstate);
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}

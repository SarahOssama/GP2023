import 'dart:async';

import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:flutter/material.dart';

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

  //helper functions
  void showPopUp(String logo, String message, List<Widget> children,
      BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 15,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5))],
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children),
              ),
            ),
          );
        },
      ),
    );
  }
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}

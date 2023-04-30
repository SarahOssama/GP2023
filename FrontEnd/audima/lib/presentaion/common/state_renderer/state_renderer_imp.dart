import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/resources/routes_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

//interact between view and state renderer
abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//Loading State (Pop Up, Full Screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  static bool popUp = false;
  LoadingState({
    required this.stateRendererType,
    this.message = "Loading...",
  });
  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

//Error State (Pop Up, Full Screen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  static bool popUp = false;

  ErrorState(this.stateRendererType, this.message);

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

//Content State
class ContentState extends FlowState {
  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;

  @override
  String getMessage() => "";
}

//empty state
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);
  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;

  @override
  String getMessage() => message;
}

//now I need to make an extension on the flow state so that i the view will have a widget which will pass the the state renderer imp and know the flow state which is at the moment to act upon it
extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() ==
            StateRendererType.popUpLoadingState) //pop up loading screen
        {
          //show pop up
          showPopUp(context, getStateRendererType(), getMessage());
          LoadingState.popUp = true;
          //show content screen
          return contentScreenWidget;
        } else {
          //full screen loading state
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      case ErrorState:
        if (LoadingState.popUp) {
          dismissDialog(context);
          LoadingState.popUp = false;
        }

        if (getStateRendererType() ==
            StateRendererType.popUpErrorState) //pop up error screen
        {
          //show pop up
          showPopUp(context, getStateRendererType(), getMessage());
          //show content screen
          return contentScreenWidget;
        } else {
          //full screen loading state
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      case EmptyState:
        return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryActionFunction: retryActionFunction,
            message: getMessage());
      case ContentState:
        if (LoadingState.popUp) {
          dismissDialog(context);
          LoadingState.popUp = false;
        }
        return contentScreenWidget;
      default:
        dismissDialog(context);

        return contentScreenWidget;
    }
  }

  dismissDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: () {})));
  }
}

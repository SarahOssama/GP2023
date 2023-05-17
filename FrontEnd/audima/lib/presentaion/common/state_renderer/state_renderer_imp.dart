import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/resources/routes_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

//interact between view and state renderer
abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
  VoidCallback getConfirmationActionFunction() => () {};
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

//confirmation message state
class ConfirmationMessageState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  String title;
  VoidCallback confirmationActionFunction;
  ConfirmationMessageState({
    required this.stateRendererType,
    this.message = "Loading...",
    this.title = "",
    required this.confirmationActionFunction,
  });
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
          //show content screen
          return contentScreenWidget;
        } else {
          //full screen loading state
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      case ConfirmationMessageState:
        dismissDialog(context);
        if (getStateRendererType() ==
            StateRendererType
                .popUpConfirmationMessageState) //pop up loading screen
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
      case ErrorState:
        dismissDialog(context);
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
        dismissDialog(context);
        return contentScreenWidget;
      default:
        dismissDialog(context);
        return contentScreenWidget;
    }
  }

  _isCurrentDialogShowing(BuildContext context) {
    // print(ModalRoute.of(context)?.isCurrent != true);
    return ModalRoute.of(context)?.isCurrent != true;
  }

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      // print(
      //     "dismissing1--------------------------------------------------------------------------");
      Navigator.of(context, rootNavigator: true).pop(true);
      // print(
      //     "dismissing2--------------------------------------------------------------------------");
    }
  }

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    // print(
    //     "a7aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    if (_isCurrentDialogShowing(context)) {
      return; // Pop-up is already showing, so don't show it again
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
          context: context,
          builder: (context) => StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              retryActionFunction: () {},
              confirmationActionFunction: getConfirmationActionFunction()),
        ));
  }
}

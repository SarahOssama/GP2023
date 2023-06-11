import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/resources/routes_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';

//interact between view and state renderer
abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
  //these next 2 functions are optional because they are only used in the confirmation edit  state
  VoidCallback? getConfirmationActionFunction() => () {};
  Widget? getListView() => const SizedBox.shrink();
  //also these for confirmation action
  VoidCallback? getCancelActionFuntion() => () {};
  String? getConfirmText() => "Confirm";
  String? getCancelText() => "Cancel";
  //functions for success
}

//Loading State (Pop Up, Full Screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
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

  ErrorState(this.stateRendererType, this.message);

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

//success state
class SuccessState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  SuccessState(this.stateRendererType, this.message);

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
}

//confirmation message state
class ConfirmationState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  VoidCallback confirmationActionFunction;
  String? confirmText = "Confirm";
  String? cancelText = "Cancel";
  VoidCallback cancelActionFunction;
  Widget? listView = const SizedBox.shrink();
  ConfirmationState(
      {required this.stateRendererType,
      this.confirmText,
      this.cancelText,
      required this.cancelActionFunction,
      required this.message,
      required this.confirmationActionFunction,
      required this.listView});
  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
  @override
  VoidCallback getConfirmationActionFunction() => confirmationActionFunction;
  @override
  Widget? getListView() => listView;
  @override
  String? getConfirmText() => confirmText;
  @override
  String? getCancelText() => cancelText;
  @override
  VoidCallback getCancelActionFuntion() => cancelActionFunction;
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
        dismissDialog(context);
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
          );
        }
      case ConfirmationState:
        dismissDialog(context);
        if (getStateRendererType() ==
            StateRendererType.popUpConfirmationState) //pop up loading screen
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
          );
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
          );
        }
      case SuccessState:
        dismissDialog(context);
        if (getStateRendererType() ==
            StateRendererType.popUpSuccessState) //pop up error screen
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
          );
        }

      case EmptyState:
        return StateRenderer(
            stateRendererType: getStateRendererType(), message: getMessage());
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
      print(getStateRendererType());
      print(
          "dismissing1--------------------------------------------------------------------------");
      Navigator.of(context, rootNavigator: true).pop(true);
      print(
          "dismissing2--------------------------------------------------------------------------");
    }
  }

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    if (_isCurrentDialogShowing(context)) {
      return; // Pop-up is already showing, so don't show it again
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            confirmationActionFunction: getConfirmationActionFunction(),
            listView: getListView(),
            cancelActionFuntion: getCancelActionFuntion(),
            confirmText: getConfirmText(),
            cancelText: getCancelText(),
          ),
        ));
  }
}

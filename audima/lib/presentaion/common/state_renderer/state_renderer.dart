import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/responsive.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  //POP UP STATES (DIALOG)
  popUpLoadingState,
  popUpErrorState,
  //FULL SCREEN STATES (FULL SCREEN)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  //CONTENT State
  contentState,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;
  StateRenderer(
      {required this.stateRendererType,
      this.message = "Loading...",
      this.title = "",
      required this.retryActionFunction});
  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popUpLoadingState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message, context)
        ]);
      case StateRendererType.popUpErrorState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          SizedBox(height: 10),
          _getMessage(message, context),
          SizedBox(height: 10),
          _getRetryButton("Ok", context)
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getColumnItems([
          _getAnimatedImage(JsonAssets.loading),
          SizedBox(height: 10),
          _getMessage(message, context),
          SizedBox(height: 10),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getColumnItems([
          _getAnimatedImage(JsonAssets.error),
          SizedBox(height: 10),
          _getMessage(message, context),
          SizedBox(height: 10),
          _getRetryButton("Retry", context)
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getColumnItems([
          _getAnimatedImage(JsonAssets.empty),
          SizedBox(height: 10),
          _getMessage(message, context),
          SizedBox(height: 10),
        ]);
      case StateRendererType.contentState:
        return Container();

      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 15,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5))],
            borderRadius: BorderRadius.all(Radius.circular(18))),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children);
  }

  Widget _getColumnItems(List<Widget> children) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children);
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
        height: 100, width: 100, child: Lottie.asset(animationName));
  }

  Widget _getMessage(String message, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(message,
              style: ResponsiveTextStyles.LoadingMessageTextStyle(context)),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  //create _getRetryButton for me
  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return SizedBox(
      height: 40,
      width: 200,
      child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () {
            if (stateRendererType == StateRendererType.fullScreenErrorState) {
              retryActionFunction.call();
            } else //means it is popup error state
            {
              Navigator.of(context).pop();
            }
          },
          child: Text(buttonTitle)),
    );
  }
}

import 'package:audima/app/constants.dart';
import 'package:audima/presentaion/mission_statement/viewmodel/mission_statement_viewmodel.dart';
import 'package:audima/responsive.dart';
import 'package:flutter/material.dart';

class ContainerWithinImage extends StatelessWidget {
  Widget mainChild;
  Widget? secondaryChild;
  double containerContentWidth;
  double containerContentHeight;
  ContainerWithinImage(
      {required this.mainChild,
      required this.containerContentHeight,
      required this.containerContentWidth,
      this.secondaryChild});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Audima',
          style: ResponsiveTextStyles.audima(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/mission-statement.jpg'),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: containerContentWidth,
                  height: containerContentHeight,
                  decoration: Constants.blackedShadowContainer,
                  child: mainChild,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              secondaryChild ?? const SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}

class ReactiveElevatedButton extends StatelessWidget {
  double? width;
  double? height;
  String text;
  void Function() onPressed;
  bool buttonColorCondition;
  bool buttonPressedCondition;
  ReactiveElevatedButton(
      {required this.text,
      required this.onPressed,
      required this.buttonColorCondition,
      required this.buttonPressedCondition,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              elevation: buttonColorCondition == false
                  ? MaterialStatePropertyAll(16)
                  : MaterialStatePropertyAll(
                      0), // increase the elevation of the button
              shadowColor: buttonColorCondition == false
                  ? MaterialStatePropertyAll(Colors.white)
                  : MaterialStatePropertyAll(
                      Colors.grey), // set the color of the button's shadow

              shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                (states) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  );
                },
              ),
              backgroundColor: buttonColorCondition
                  ? MaterialStatePropertyAll(Colors.grey)
                  : MaterialStatePropertyAll(Colors.white)),
          onPressed: (buttonPressedCondition) ? null : onPressed,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: ResponsiveTextStyles.startYourBusinessJourney(context),
            ),
          ),
        ),
      ],
    );
  }
}

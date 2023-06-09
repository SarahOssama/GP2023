import 'package:audima/app/constants.dart';
import 'package:audima/presentaion/mission_statement/viewmodel/mission_statement_viewmodel.dart';
import 'package:audima/responsive.dart';
import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  String previousRoute;
  Widget child;
  MainScaffold({required this.child, required this.previousRoute});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/mainthemevertical.jpg'),
              ),
            ),
          ),
          AppBar(
            title: Text(
              'Audima',
              style: ResponsiveTextStyles.audimaMain(context),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Constants.darkBlueColorTheme,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          child
        ],
      ),
    );
  }
}

class BlackedShadowContainer extends StatelessWidget {
  Widget child;
  double? width;
  double? height;
  BlackedShadowContainer({required this.child, this.width, this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: Constants.blackedShadowContainer,
      child: child,
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
        Container(
          child: ElevatedButton(
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
                    : MaterialStatePropertyAll(Constants.yellowColorTheme)),
            onPressed: (buttonPressedCondition) ? null : onPressed,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: ResponsiveTextStyles.startYourBusinessJourney(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

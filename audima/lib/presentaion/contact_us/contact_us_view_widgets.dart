import 'package:flutter/material.dart';

import '../resources/assets_manager.dart';
import '../resources/styles_manager.dart';

InputDecoration contactUsInputDecoration(String hintText, String lableText) {
  return InputDecoration(
    hintText: hintText,
    alignLabelWithHint: true,
    labelText: lableText,
    labelStyle: const TextStyle(color: Colors.black),
    border: const OutlineInputBorder(),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 69, 107, 174)),
    ),
  );
}

extension EmailValidator on String {
  bool isValidEmail(String email) {
    if (email == "") {
      return true;
    }
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class DesktopContactContainer extends StatelessWidget {
  final String text1;
  final String text2;
  final IconData icon;

  const DesktopContactContainer({
    required this.icon,
    required this.text1,
    required this.text2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          // Color.fromARGB(255, 156, 178, 188),
          color: Color.fromARGB(255, 156, 178, 188),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CustomizedTextNotCentered(
                      text: text1, textStyle: StylesManager.contactUsSubmit),
                ],
              ),
              CustomizedTextNotCentered(
                  text: text2,
                  textStyle: StylesManager.contactUsContainerSecondryline),
            ],
          ),
        ),
      ),
    );
  }
}

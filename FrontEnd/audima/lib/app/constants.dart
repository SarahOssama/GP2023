import 'package:flutter/material.dart';

class Constants {
  static const String baseUrl = "https://api.metatext.ai/hub-inference";
  static const String videoManipulationUrl = "http://192.168.1.55:8000";
  static const String empty = "";
  static const int zero = 0;
  static const double zeroDouble = 0.0;
  static const Map<String, dynamic> zeroMap = {};
  static const Duration apiTimeout = Duration(minutes: 1);
  static const String token = "Z0CDIgI42M5hggX0bpBB61UZswN4NiHNaqqsFIWd";
  static const Color whiteColorTheme = Color(0xffE7E7E7);
  static const Color yellowColorTheme = Color(0xffFCB911);
  static const Color darkBlueColorTheme = Color(0xff333180);
  static bool BusinessInfoScreenViewStatus = false;
  static const Decoration blackedShadowContainer = BoxDecoration(
    image: DecorationImage(
        opacity: 0.4,
        image: AssetImage('assets/images/audima_bg.jpg'),
        fit: BoxFit.cover),
    boxShadow: [
      BoxShadow(
          color: Colors.black, //New
          blurRadius: 25.0,
          offset: Offset(0, -15)),
      BoxShadow(
          color: Colors.black, //New
          blurRadius: 25.0,
          offset: Offset(0, 15))
    ],
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );
}

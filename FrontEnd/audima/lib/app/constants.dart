import 'package:flutter/material.dart';

class Constants {
  static const String baseUrl = "https://api.metatext.ai/hub-inference";
  static const String videoManipulationUrl = "http://192.168.1.100:8000";
  static const String empty = "";
  static const int zero = 0;
  static const double zeroDouble = 0.0;
  static const Map<String, dynamic> zeroMap = {};
  static const Duration apiTimeout = Duration(minutes: 1);
  static const String token = "Z0CDIgI42M5hggX0bpBB61UZswN4NiHNaqqsFIWd";
  static const String missionStatementApiKey =
      "Z0CDIgI42M5hggX0bpBB61UZswN4NiHNaqqsFIWd";
  static bool BusinessInfoScreenViewStatus = false;
  static const Decoration blackedShadowContainer = BoxDecoration(
    boxShadow: [
      BoxShadow(
          color: Colors.black, //New
          blurRadius: 25.0,
          offset: Offset(0, -10)),
      BoxShadow(
          color: Colors.black, //New
          blurRadius: 25.0,
          offset: Offset(0, 25))
    ],
    color: Colors.black,
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );
}

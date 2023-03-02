import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StylesManager {
  static TextStyle contactUsHeadLine = GoogleFonts.openSans(
      letterSpacing: 1.5,
      fontSize: 40,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle contactUsSecondyline = GoogleFonts.openSans(
    letterSpacing: 1.5,
    fontSize: 15,
    color: Colors.black,
  );
  static TextStyle contactUsSubmit = GoogleFonts.openSans(
      letterSpacing: 1.5,
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold);
  static TextStyle contactUsContainerSecondryline = GoogleFonts.openSans(
    letterSpacing: 1.5,
    fontSize: 18,
    color: Colors.white,
  );
  static TextStyle snackbarErrorMessage = GoogleFonts.openSans(
    letterSpacing: 1.5,
    fontSize: 25,
    color: Colors.white,
  );
}

import 'package:audima/app/constants.dart';
import 'package:audima/domain/model/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveValues {
  //AspectRatios/////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // static double homeBigImageAspectRatio(context) {
  //   return ResponsiveValue(
  //     context,
  //     defaultValue: 2.5,
  //     valueWhen: [
  //       const Condition.smallerThan(name: MOBILE, value: 1.3),
  //       const Condition.smallerThan(name: TABLET, value: 2.0),
  //     ],
  //   ).value!;
  // }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ResponsiveTextStyles {
  //app view text styles////////////////////////////////////////////////////////////////////////////////////////////////////////
  static TextStyle audimaHome(context) {
    return GoogleFonts.lobster(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 45.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 40.0),
          const Condition.smallerThan(name: TABLET, value: 30.0),
        ],
      ).value,
      color: Colors.white,
    );
  }

  static TextStyle audimaMain(context) {
    return GoogleFonts.lobster(
        fontSize: ResponsiveValue(
          context,
          defaultValue: 45.0,
          valueWhen: [
            const Condition.smallerThan(name: DESKTOP, value: 40.0),
            const Condition.smallerThan(name: TABLET, value: 30.0),
          ],
        ).value,
        color: Constants.darkBlueColorTheme);
  }

  //state renderer  text styles////////////////////////////////////////////////////////////////////////////////////////
  static TextStyle loadingMessageTextStyle(context) {
    return GoogleFonts.sora(
        fontSize: ResponsiveValue(
          context,
          defaultValue: 15.0,
          valueWhen: [
            const Condition.smallerThan(name: DESKTOP, value: 15.0),
            const Condition.smallerThan(name: "SMALLERDESKTOP", value: 15.0),
            const Condition.smallerThan(name: TABLET, value: 15.0),
          ],
        ).value,
        color: Colors.black,
        fontWeight: FontWeight.bold);
  }

//splash view text styles////////////////////////////////////////////////////////////////////////////////////////////////////////
  static TextStyle audimaSplash(context) {
    return GoogleFonts.lobster(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 60.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 45.0),
          const Condition.smallerThan(name: TABLET, value: 30.0),
        ],
      ).value,
      color: Colors.white,
    );
  }

//onboarding view text styles////////////////////////////////////////////////////////////////////////////////////////////////////////
  static TextStyle onBoardingFirstTitle(context) {
    return GoogleFonts.lobster(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 30.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 30.0),
        ],
      ).value,
      color: Color.fromARGB(255, 19, 17, 83),
    );
  }

  static TextStyle skipTextStyle(context) {
    return GoogleFonts.lobster(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 20.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 20.0),
        ],
      ).value,
      color: Constants.yellowColorTheme,
    );
  }

  //home view text styles////////////////////////////////////////////////////////////////////////////////////////////////////////
  static TextStyle startYourBusinessJourney(context) {
    return GoogleFonts.lobster(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 13.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 18.0),
        ],
      ).value,
      color: Constants.darkBlueColorTheme,
    );
  }

  static TextStyle skiForVideo(context) {
    return GoogleFonts.lobster(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 13.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 18.0),
        ],
      ).value,
      color: Constants.whiteColorTheme,
    );
  }

  static TextStyle nextButtonStyle(context) {
    return GoogleFonts.lobster(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 13.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 18.0),
        ],
      ).value,
      color: Constants.yellowColorTheme,
    );
  }

//business info view text styles////////////////////////////////////////////////////////////////////////////////////////
  static TextStyle businessDetailMainTextStyle(context) {
    return GoogleFonts.sora(
        fontSize: ResponsiveValue(
          context,
          defaultValue: 30.0,
          valueWhen: [
            const Condition.smallerThan(name: DESKTOP, value: 27.0),
            const Condition.smallerThan(name: "SMALLERDESKTOP", value: 25.0),
            const Condition.smallerThan(name: TABLET, value: 20.0),
          ],
        ).value,
        color: Colors.white,
        fontWeight: FontWeight.bold);
  }

  static TextStyle businessDetailTextStyle(context) {
    return GoogleFonts.sora(
        // shadows: <Shadow>[
        //   const Shadow(
        //     blurRadius: 2,
        //     color: Colors.black,
        //   ),
        // ],
        fontSize: ResponsiveValue(
          context,
          defaultValue: 30.0,
          valueWhen: [
            const Condition.smallerThan(name: DESKTOP, value: 27.0),
            const Condition.smallerThan(name: "SMALLERDESKTOP", value: 25.0),
            const Condition.smallerThan(name: TABLET, value: 20.0),
          ],
        ).value,
        color: Colors.white,
        fontWeight: FontWeight.bold);
  }

  static TextStyle businessInfoHintStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 20.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 16.0),
          const Condition.smallerThan(name: TABLET, value: 12.0),
        ],
      ).value,
      color: Color.fromARGB(255, 219, 217, 217),
    );
  }

  static TextStyle brandPersonalityTextStyle(context) {
    return GoogleFonts.sora(
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 10,
            color: Colors.black,
          ),
        ],
        fontSize: ResponsiveValue(
          context,
          defaultValue: 20.0,
          valueWhen: [
            const Condition.smallerThan(name: DESKTOP, value: 27.0),
            const Condition.smallerThan(name: "SMALLERDESKTOP", value: 25.0),
            const Condition.smallerThan(name: TABLET, value: 11.0),
          ],
        ).value,
        color: Colors.white,
        fontWeight: FontWeight.bold);
  }

  static TextStyle companyIndustryTypesTextStyle(context) {
    return GoogleFonts.sora(
        fontSize: ResponsiveValue(
          context,
          defaultValue: 26.0,
          valueWhen: [
            const Condition.smallerThan(name: DESKTOP, value: 27.0),
            const Condition.smallerThan(name: "SMALLERDESKTOP", value: 25.0),
            const Condition.smallerThan(name: TABLET, value: 20.0),
          ],
        ).value,
        color: Constants.darkBlueColorTheme,
        fontWeight: FontWeight.bold);
  }

  //mission statement view text styles////////////////////////////////////////////////////////////////////////////////////////
  static TextStyle missionStatementTextStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 15.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 27.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 25.0),
          const Condition.smallerThan(name: TABLET, value: 15.0),
        ],
      ).value,
      color: Colors.white,
    );
  }
  //business video view text styles////////////////////////////////////////////////////////////////////////////////////////

  //final presentation view text styles////////////////////////////////////////////////////////////////////////////////////////
  static TextStyle videoAndBusinessDescriptionTextStyle(context) {
    return GoogleFonts.lobster(
      shadows: <Shadow>[
        const Shadow(
          blurRadius: 10,
          color: Colors.black,
        ),
      ],
      fontSize: ResponsiveValue(
        context,
        defaultValue: 25.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 40.0),
          const Condition.smallerThan(name: TABLET, value: 25.0),
        ],
      ).value,
      color: Constants.darkBlueColorTheme,
    );
  }

  static TextStyle finalBusinessStatementTextStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 10.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 27.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 25.0),
          const Condition.smallerThan(name: TABLET, value: 10.0),
        ],
      ).value,
      color: Colors.white,
    );
  }
}

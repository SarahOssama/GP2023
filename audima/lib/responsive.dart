import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveValues {
  //AspectRatios/////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static double homeBigImageAspectRatio(context) {
    return ResponsiveValue(
      context,
      defaultValue: 2.5,
      valueWhen: [
        const Condition.smallerThan(name: MOBILE, value: 1.3),
        const Condition.smallerThan(name: TABLET, value: 2.0),
      ],
    ).value!;
  }

//paddings////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static double servingYourVisionLeftPadding(context) {
    return ResponsiveValue(
      context,
      defaultValue: 100.0,
      valueWhen: [
        const Condition.smallerThan(name: "SERVINGYOURVISION2", value: 200.0),
        const Condition.smallerThan(name: DESKTOP, value: 100.0),
        const Condition.smallerThan(name: TABLET, value: 20.0),
      ],
    ).value!;
  }

  static double servingYourVisionBottomPadding(context) {
    return ResponsiveValue(
      context,
      defaultValue: 80.0,
      valueWhen: [
        const Condition.smallerThan(name: TABLET, value: 120.0),
      ],
    ).value!;
  }

  static double mainTabBarLabelLeftPadding(context) {
    return ResponsiveValue(
      context,
      defaultValue: 30.0,
      valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 16.0),
        const Condition.smallerThan(name: TABLET, value: 5.0),
      ],
    ).value!;
  }

  static double mainTabBarLabelrightPadding(context) {
    return ResponsiveValue(
      context,
      defaultValue: 30.0,
      valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 16.0),
        const Condition.smallerThan(name: TABLET, value: 5.0),
      ],
    ).value!;
  }

  static double productTabBarLabelLeftPadding(context) {
    return ResponsiveValue(
      context,
      defaultValue: 30.0,
      valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 20.0),
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 13.0),
        const Condition.smallerThan(name: TABLET, value: 8.0),
      ],
    ).value!;
  }

  static double productTabBarLabelrightPadding(context) {
    return ResponsiveValue(
      context,
      defaultValue: 30.0,
      valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 20.0),
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 13.0),
        const Condition.smallerThan(name: TABLET, value: 8.0),
      ],
    ).value!;
  }

  static double contactUsTextFieldsLeftPadding(context) {
    return ResponsiveValue(
      context,
      defaultValue: 150.0,
      valueWhen: [
        const Condition.smallerThan(name: "MEDIUMDESKTOP", value: 130.0),
        const Condition.smallerThan(name: "LARGERDESKTOP", value: 110.0),
        const Condition.smallerThan(name: DESKTOP, value: 90.0),
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 70.0),
        const Condition.smallerThan(name: "LARGERTABLET", value: 40.0),
        const Condition.smallerThan(name: MOBILE, value: 20.0),
      ],
    ).value!;
  }

  static double contactUsServicesLeftRightPadding(context) {
    return ResponsiveValue(
      context,
      defaultValue: 350.0,
      valueWhen: [
        const Condition.smallerThan(name: "MEDIUMDESKTOP", value: 250.0),
        const Condition.smallerThan(name: "LARGERDESKTOP", value: 220.0),
        const Condition.smallerThan(name: DESKTOP, value: 100.0),
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 50.0),
        const Condition.smallerThan(name: "LARGERTABLET", value: 20.0),
        const Condition.smallerThan(name: MOBILE, value: 20.0),
        const Condition.smallerThan(name: "SMALLERMOBILE", value: 10.0),
      ],
    ).value!;
  }

  static double desktopContactContainerPadding(context) {
    return ResponsiveValue(
      context,
      defaultValue: 30.0,
      valueWhen: [
        const Condition.smallerThan(name: MOBILE, value: 20.0),
        const Condition.smallerThan(name: "SMALLERMOBILE", value: 10.0),
      ],
    ).value!;
  }
//radius///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static double tmicoLogoRadius(context) {
    return ResponsiveValue(
      context,
      defaultValue: 22.0,
      valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 17.0),
        const Condition.smallerThan(name: TABLET, value: 13.0),
      ],
    ).value!;
  }

  static double productImageRadius(context) {
    return ResponsiveValue(
      context,
      defaultValue: 250.0,
      valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 200.0),
        const Condition.smallerThan(name: "SMALLERTABLET", value: 150.0),
      ],
    ).value!;
  }

//height&width///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static double homeSliderHeight(context) {
    return ResponsiveValue(
      context,
      defaultValue: 300.0,
      valueWhen: [
        const Condition.smallerThan(name: "LARGERDESKTOP", value: 250.0),
        const Condition.smallerThan(name: DESKTOP, value: 230.0),
        const Condition.smallerThan(name: TABLET, value: 210.0),
        const Condition.smallerThan(name: "SMALLERTABLET", value: 150.0),
        const Condition.smallerThan(name: MOBILE, value: 130.0),
      ],
    ).value!;
  }

  static double servicesContainerHeight(context) {
    return ResponsiveValue(
      context,
      defaultValue: 500.0,
      valueWhen: [
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 750.0),
        const Condition.smallerThan(name: "LARGERDESKTOP", value: 450.0),
        const Condition.smallerThan(name: DESKTOP, value: 400.0),
      ],
    ).value!;
  }

  static double productImageParagWidth(context) {
    return ResponsiveValue(
      context,
      defaultValue: 800.0,
      valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 600.0),
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 500.0),
        const Condition.smallerThan(name: TABLET, value: 400.0),
        const Condition.smallerThan(name: "MEDIUMTABLET", value: 300.0),
      ],
    ).value!;
  }

  static double singleProductImageHeight(context) {
    return ResponsiveValue(
      context,
      defaultValue: 600.0,
      valueWhen: [
        const Condition.smallerThan(name: "LARGERDESKTOP", value: 600.0),
        const Condition.smallerThan(name: DESKTOP, value: 500.0),
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 500.0),
        const Condition.smallerThan(name: "LARGERTABLET", value: 500.0),
        const Condition.smallerThan(name: MOBILE, value: 550.0),
        const Condition.smallerThan(name: "SMALLERMOBILE", value: 500.0),
      ],
    ).value!;
  }

  static double submitWidth(context) {
    return ResponsiveValue(
      context,
      defaultValue: 250.0,
      valueWhen: [
        const Condition.smallerThan(name: "LARGERDESKTOP", value: 200.0),
        const Condition.smallerThan(name: DESKTOP, value: 150.0),
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 120.0),
        const Condition.smallerThan(name: "LARGERTABLET", value: 100.0),
      ],
    ).value!;
  }

  static double aboutUsMainImageHeight(context) {
    return ResponsiveValue(
      context,
      defaultValue: 600.0,
      valueWhen: [
        const Condition.smallerThan(name: "LARGERDESKTOP", value: 550.0),
        const Condition.smallerThan(name: DESKTOP, value: 500.0),
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 450.0),
        const Condition.smallerThan(name: TABLET, value: 400.0),
        const Condition.smallerThan(name: "SMALLERTABLET", value: 360.0),
        const Condition.smallerThan(name: MOBILE, value: 300.0),
        const Condition.smallerThan(name: "SMALLERMOBILE", value: 260.0),
        const Condition.smallerThan(name: "SMALLESTMOBILE", value: 200.0),
      ],
    ).value!;
  }

  static double ourTeamContainerHeight(context) {
    return ResponsiveValue(
      context,
      defaultValue: 1000.0,
      valueWhen: [
        const Condition.smallerThan(name: "LARGERDESKTOP", value: 950.0),
        const Condition.smallerThan(name: DESKTOP, value: 900.0),
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 850.0),
        const Condition.smallerThan(name: TABLET, value: 800.0),
        const Condition.smallerThan(name: "SMALLERTABLET", value: 700.0),
        const Condition.smallerThan(name: MOBILE, value: 600.0),
        const Condition.smallerThan(name: "SMALLERMOBILE", value: 500.0),
        const Condition.smallerThan(name: "SMALLESTMOBILE", value: 500.0),
      ],
    ).value!;
  }

  static double aboutUsSecondrylineWidth(context) {
    return ResponsiveValue(
      context,
      defaultValue: 500.0,
      valueWhen: [
        const Condition.smallerThan(name: "LARGERDESKTOP", value: 450.0),
        const Condition.smallerThan(name: DESKTOP, value: 400.0),
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 350.0),
        const Condition.smallerThan(name: TABLET, value: 300.0),
        const Condition.smallerThan(name: "SMALLERTABLET", value: 270.0),
        const Condition.smallerThan(name: MOBILE, value: 250.0),
        const Condition.smallerThan(name: "SMALLERMOBILE", value: 230.0),
        const Condition.smallerThan(name: "SMALLESTMOBILE", value: 200.0),
      ],
    ).value!;
  }

  static double aboutUsDataContainerwidth(context) {
    return ResponsiveValue(
      context,
      defaultValue: 400.0,
      valueWhen: [
        const Condition.smallerThan(name: "LARGERDESKTOP", value: 300.0),
        const Condition.smallerThan(name: DESKTOP, value: 400.0),
      ],
    ).value!;
  }

  static double aboutUsBrowseProductsWidth(context) {
    return ResponsiveValue(
      context,
      defaultValue: 300.0,
      valueWhen: [
        const Condition.smallerThan(name: "LARGERDESKTOP", value: 260.0),
        const Condition.smallerThan(name: DESKTOP, value: 240.0),
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 220.0),
        const Condition.smallerThan(name: TABLET, value: 200.0),
        const Condition.smallerThan(name: "SMALLERTABLET", value: 180.0),
        const Condition.smallerThan(name: MOBILE, value: 170.0),
        const Condition.smallerThan(name: "SMALLERMOBILE", value: 150.0),
        const Condition.smallerThan(name: "SMALLESTMOBILE", value: 140.0),
      ],
    ).value!;
  }

  static double ourTeamHeight(context) {
    return ResponsiveValue(
      context,
      defaultValue: 500.0,
      valueWhen: [
        const Condition.smallerThan(name: "LARGERTABLET", value: 400.0),
        const Condition.smallerThan(name: "MEDIUMTABLET", value: 300.0),
        const Condition.smallerThan(name: "SMALLERTABLET", value: 270.0),
        const Condition.smallerThan(name: MOBILE, value: 220.0),
      ],
    ).value!;
  }

//icons size/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static double leftRightAngleIconSize(context) {
    return ResponsiveValue(
      context,
      defaultValue: 60.0,
      valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 50.0),
        const Condition.smallerThan(name: "SMALLERDESKTOP", value: 45.0),
        const Condition.smallerThan(name: TABLET, value: 35.0),
      ],
    ).value!;
  }
//slidersViewPorts///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static double homeSliderViewPort(context) {
    return ResponsiveValue(
      context,
      defaultValue: 0.3,
      valueWhen: [
        const Condition.smallerThan(name: TABLET, value: 0.4),
        const Condition.smallerThan(name: MOBILE, value: 0.5),
      ],
    ).value!;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ResponsiveTextStyles {
  //home view text styles////////////////////////////////////////////////////////////////////////////////////////////////////////
  static TextStyle audima(context) {
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

  static TextStyle mainTabsStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 20.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 16.0),
          const Condition.smallerThan(name: TABLET, value: 12.0),
        ],
      ).value,
      color: Colors.black,
    );
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

  static TextStyle servingYourVisionLargerStyle(context) {
    return GoogleFonts.lobster(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 60.0,
        valueWhen: [
          const Condition.smallerThan(name: "SERVINGYOURVISION2", value: 45.0),
          const Condition.smallerThan(name: DESKTOP, value: 35.0),
          const Condition.smallerThan(name: TABLET, value: 25.0),
          // Condition.smallerThan(
          //     name: MOBILE, value: 18.0),
        ],
      ).value,
      color: Colors.white,
    );
  }

  static TextStyle servingYourVisionSmallerStyle(context) {
    return GoogleFonts.lobster(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 22.0,
        valueWhen: [
          const Condition.smallerThan(name: "SMALLERMOBILE", value: 18.0),
          const Condition.smallerThan(name: "SMALLESTMOBILE", value: 15.0),
        ],
      ).value,
      color: Colors.black,
    );
  }

  static TextStyle ourServicesStyle(context) {
    return GoogleFonts.lato(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 40.0,
        valueWhen: [
          const Condition.smallerThan(name: "LARGERDESKTOP", value: 30.0),
          const Condition.smallerThan(name: TABLET, value: 25.0),
          const Condition.smallerThan(name: MOBILE, value: 20.0),
        ],
      ).value,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle servicesHeadlineStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 27.0,
        valueWhen: [
          const Condition.smallerThan(name: "LARGERDESKTOP", value: 21.0),
          const Condition.smallerThan(name: DESKTOP, value: 17.0),
          const Condition.smallerThan(name: TABLET, value: 15.0),
          const Condition.smallerThan(name: MOBILE, value: 13.0),
        ],
      ).value,
      color: Colors.white,
    );
  }

  static TextStyle servicesSecondrylineStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 17.0,
        valueWhen: [
          const Condition.smallerThan(name: "LARGERDESKTOP", value: 15.0),
          const Condition.smallerThan(name: DESKTOP, value: 13.0),
          const Condition.smallerThan(name: TABLET, value: 11.0),
          const Condition.smallerThan(name: MOBILE, value: 9.0),
        ],
      ).value,
      color: Colors.white60,
    );
  }

  static TextStyle navigationDrawerTextsStyles(context) {
    return GoogleFonts.sora(
      fontSize: 18,
      color: Colors.white,
    );
  }
  //products view text styles////////////////////////////////////////////////////////////////////////////////////////

  static TextStyle productTabsStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 18.0,
        valueWhen: [
          const Condition.smallerThan(name: "MEDIUMDESKTOP", value: 15.0),
          const Condition.smallerThan(name: DESKTOP, value: 14.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 13.0),
          const Condition.smallerThan(name: "LARGERTABLET", value: 12.0),
          const Condition.smallerThan(name: TABLET, value: 11.0),
        ],
      ).value,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle businessDetailMainTextStyle(context) {
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
        color: Colors.black,
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

  static TextStyle productOnImageParagTextStyle(context) {
    return GoogleFonts.nunito(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 15.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 14.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 13.0),
          const Condition.smallerThan(name: TABLET, value: 12.0),
        ],
      ).value,
      color: Colors.white,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
    );
  }

  static TextStyle browseProductsStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 35.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 30.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 25.0),
          const Condition.smallerThan(name: TABLET, value: 20.0),
        ],
      ).value,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle categoriesStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 20.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 17.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 12.9),
          const Condition.smallerThan(name: "LARGERTABLET", value: 20.0),
        ],
      ).value,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle productHeadLineStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 27.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 23.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 20.9),
          const Condition.smallerThan(name: "LARGERTABLET", value: 18.0),
        ],
      ).value,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle productSecondrylineStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 18.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 17.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 15.9),
          const Condition.smallerThan(name: "LARGERTABLET", value: 13.0),
        ],
      ).value,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle insideProductHeadlineStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 27.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 23.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 20.9),
          const Condition.smallerThan(name: "LARGERTABLET", value: 18.0),
          const Condition.smallerThan(name: MOBILE, value: 16.0),
          const Condition.smallerThan(name: "SMALLERMOBILE", value: 15.0),
        ],
      ).value,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle insideProductSecondrylineStyle(context) {
    return GoogleFonts.sora(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 18.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 17.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 15.9),
          const Condition.smallerThan(name: "LARGERTABLET", value: 13.0),
          const Condition.smallerThan(name: MOBILE, value: 12.0),
          const Condition.smallerThan(name: "SMALLERMOBILE", value: 11.0),
        ],
      ).value,
      fontWeight: FontWeight.w200,
    );
  }

  static TextStyle getInTouchStyle(context) {
    return GoogleFonts.sora(
      letterSpacing: 1.5,
      fontSize: ResponsiveValue(
        context,
        defaultValue: 40.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 35.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 28.0),
          const Condition.smallerThan(name: TABLET, value: 30.0),
          const Condition.smallerThan(name: MOBILE, value: 25.0),
          const Condition.smallerThan(name: "SMALLESTMOBILE", value: 20.0),
        ],
      ).value,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
      shadows: <Shadow>[
        Shadow(
          offset: const Offset(1, 0),
          blurRadius: 3.0,
          color: Colors.black.withOpacity(0.3),
        ),
      ],
    );
  }

  static TextStyle aboutUsStyle(context) {
    return GoogleFonts.lato(
      letterSpacing: 2,
      height: 1.2,
      fontSize: ResponsiveValue(
        context,
        defaultValue: 80.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 55.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 45.0),
          const Condition.smallerThan(name: TABLET, value: 40.0),
          const Condition.smallerThan(name: "SMALLERTABLET", value: 37.0),
          const Condition.smallerThan(name: MOBILE, value: 34.0),
          const Condition.smallerThan(name: "SMALLERMOBILE", value: 30.0),
          const Condition.smallerThan(name: "SMALLESTMOBILE", value: 25.0),
        ],
      ).value,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    );
  }

  static TextStyle startYourBusinessJourney(context) {
    return GoogleFonts.lato(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 20.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 18.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 16.0),
          const Condition.smallerThan(name: TABLET, value: 15.0),
          const Condition.smallerThan(name: "SMALLERTABLET", value: 14.0),
          const Condition.smallerThan(name: MOBILE, value: 12.0),
          const Condition.smallerThan(name: "SMALLERMOBILE", value: 10.0),
          const Condition.smallerThan(name: "SMALLESTMOBILE", value: 9.0),
        ],
      ).value,
      color: Colors.black,
    );
  }

  static TextStyle aboutUsDataContainerStyle1(context) {
    return GoogleFonts.lato(
        height: 1.4,
        letterSpacing: 1.1,
        fontSize: ResponsiveValue(
          context,
          defaultValue: 20.0,
          valueWhen: [
            const Condition.smallerThan(name: "LARGERDESKTOP", value: 18.0),
            const Condition.smallerThan(name: DESKTOP, value: 20.0),
          ],
        ).value,
        color: Colors.black,
        fontWeight: FontWeight.w900);
  }

  static TextStyle aboutUsDataContainerStyle2(context) {
    return GoogleFonts.lato(
      height: 1.4,
      fontSize: ResponsiveValue(
        context,
        defaultValue: 18.0,
        valueWhen: [
          const Condition.smallerThan(name: "LARGERDESKTOP", value: 16.0),
          const Condition.smallerThan(name: DESKTOP, value: 18.0),
        ],
      ).value,
      color: Colors.black.withOpacity(0.5),
    );
  }

  static TextStyle ourStoryStyle(context) {
    return GoogleFonts.lato(
        height: 1.5,
        fontSize: ResponsiveValue(
          context,
          defaultValue: 42.0,
          valueWhen: [
            const Condition.smallerThan(name: DESKTOP, value: 30.0),
          ],
        ).value,
        fontWeight: FontWeight.w700,
        color: Colors.black);
  }

  static TextStyle ourStorySecondryStyle(context) {
    return GoogleFonts.lato(
      height: 1.5,
      fontSize: ResponsiveValue(
        context,
        defaultValue: 20.0,
        valueWhen: [
          const Condition.smallerThan(name: DESKTOP, value: 16.0),
          const Condition.smallerThan(name: MOBILE, value: 14.0),
          const Condition.smallerThan(name: "SMALLERMOBILE", value: 13.0),
          const Condition.smallerThan(name: "SMALLESTMOBILE", value: 12.0),
        ],
      ).value,
      color: Colors.black.withOpacity(0.5),
    );
  }

  static TextStyle getStartedStyle(context) {
    return GoogleFonts.lato(
      letterSpacing: 2,
      height: 1.2,
      fontSize: ResponsiveValue(
        context,
        defaultValue: 50.0,
        valueWhen: [
          const Condition.smallerThan(name: "LARGERDESKTOP", value: 40.0),
          const Condition.smallerThan(name: DESKTOP, value: 35.0),
          const Condition.smallerThan(name: "SMALLERDESKTOP", value: 30.0),
          const Condition.smallerThan(name: TABLET, value: 28.0),
          const Condition.smallerThan(name: "SMALLERTABLET", value: 29.0),
          const Condition.smallerThan(name: MOBILE, value: 25.0),
          const Condition.smallerThan(name: "SMALLERMOBILE", value: 23.0),
          const Condition.smallerThan(name: "SMALLESTMOBILE", value: 20.0),
        ],
      ).value,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    );
  }
}

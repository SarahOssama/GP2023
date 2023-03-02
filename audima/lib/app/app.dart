import 'package:flutter/material.dart';
import 'package:audima/presentaion/resources/routes_manager.dart';
import 'package:responsive_framework/responsive_framework.dart';
// precacheImage(
//         const NetworkImage(SlitLampMicroscopesImages.slitLamp), context);
//     precacheImage(const NetworkImage(SlitLampMicroscopesImages.at1), context);
//     precacheImage(
//         const NetworkImage(SlitLampMicroscopesImages.at1Product), context);
//     precacheImage(
//         const NetworkImage(SlitLampMicroscopesImages.gl30Product), context);
//     precacheImage(
//         const NetworkImage(SlitLampMicroscopesImages.gl700Product), context);
//     precacheImage(const NetworkImage(SlitLampMicroscopesImages.ms1), context);

//     precacheImage(
//         const NetworkImage(SlitLampMicroscopesImages.ms1Product), context);
//     precacheImage(
//         const NetworkImage(SlitLampMicroscopesImages.nswgl700Product), context);
//     precacheImage(const NetworkImage(SlitLampMicroscopesImages.show), context);
//     precacheImage(
//         const NetworkImage(SlitLampMicroscopesImages.slitLampMicroscopes),
//         context);

//     precacheImage(
//         const NetworkImage(SlitLampMicroscopesImages.slitLamp700GLBlur),
//         context);
//     precacheImage(
//         const NetworkImage(SlitLampMicroscopesImages.slitLamp700GL), context);

//     precacheImage(
//         const NetworkImage(SlitLampMicroscopesImages.slitLamp30GLSide),
//         context);
//     precacheImage(
//         const NetworkImage(SlitLampMicroscopesImages.slitLamp30GLFront),
//         context);
//     //
//     precacheImage(const NetworkImage(OperatingMicroscopesImages.om19), context);
//     precacheImage(const NetworkImage(OperatingMicroscopesImages.om6), context);

//     precacheImage(
//         const NetworkImage(OperatingMicroscopesImages.om6Blur), context);
//     precacheImage(const NetworkImage(OperatingMicroscopesImages.om9), context);

//     precacheImage(
//         const NetworkImage(OperatingMicroscopesImages.om9Blur), context);
//     precacheImage(
//         const NetworkImage(OperatingMicroscopesImages.oom19), context);
//     precacheImage(const NetworkImage(OperatingMicroscopesImages.oom6), context);

//     precacheImage(const NetworkImage(OperatingMicroscopesImages.oom9), context);
//     precacheImage(
//         const NetworkImage(OperatingMicroscopesImages.operatingMicroscopes),
//         context);
//     precacheImage(const NetworkImage(OperatingMicroscopesImages.show), context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.accuon), context);

//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.arkmBack), context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.arkmThumb), context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.cp40Front), context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.cp40Side), context);

//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.cp40Thumb), context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.diagnostics),
//         context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.mt266), context);

//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.show), context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.vt5Thumb), context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.vt5Blury), context);

//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.vt5), context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.tf600), context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.snt700lensView),
//         context);

//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.snt700Thumb),
//         context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.snt700FrontView),
//         context);

//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.snt700CloseView),
//         context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.snt700BlurView),
//         context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.smTube), context);
//     precacheImage(
//         const NetworkImage(DiagnosticsAndSpecialistImages.smTubeThumb),
//         context);
//     //
//     precacheImage(const NetworkImage(ImagingSystemsImages.dis1), context);
//     precacheImage(
//         const NetworkImage(ImagingSystemsImages.imagingSystems), context);
//     precacheImage(const NetworkImage(ImagingSystemsImages.show), context);
//     precacheImage(const NetworkImage(ImagingSystemsImages.td10), context);
//     //
//     precacheImage(
//         const NetworkImage(OpthalmicFurnituresImages.deltaQ), context);
//     precacheImage(
//         const NetworkImage(OpthalmicFurnituresImages.drone4), context);
//     precacheImage(
//         const NetworkImage(OpthalmicFurnituresImages.drone41), context);
//     precacheImage(
//         const NetworkImage(OpthalmicFurnituresImages.furnitures), context);
//     precacheImage(const NetworkImage(OpthalmicFurnituresImages.mds14), context);
//     precacheImage(const NetworkImage(OpthalmicFurnituresImages.show), context);
//     precacheImage(const NetworkImage(OpthalmicFurnituresImages.zulu1), context);
//     precacheImage(const NetworkImage(OpthalmicFurnituresImages.zulu2), context);
//     precacheImage(const NetworkImage(OpthalmicFurnituresImages.zulu3), context);

//     precacheImage(const NetworkImage(OtherImages.about1Image), context);
//     precacheImage(const NetworkImage(OtherImages.about2Image), context);
//     precacheImage(const NetworkImage(OtherImages.about3Image), context);
//     precacheImage(const NetworkImage(OtherImages.aboutImage), context);
//     precacheImage(const NetworkImage(OtherImages.contactUsImage), context);
//     precacheImage(const NetworkImage(OtherImages.team), context);
//     precacheImage(const NetworkImage(TmicoImages.tmicoLogo), context);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          breakpoints: const [
            ResponsiveBreakpoint.resize(210, name: "SMALLESTEVERMOBILE"),
            ResponsiveBreakpoint.resize(289, name: "SMALLESTMOBILE"),
            ResponsiveBreakpoint.resize(357, name: "SMALLERMOBILE"),
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.resize(560, name: "SMALLERTABLET"),
            ResponsiveBreakpoint.resize(620, name: "SMALLERMEDIUMTABLET"),
            ResponsiveBreakpoint.resize(650, name: "MEDIUMTABLET"),
            ResponsiveBreakpoint.resize(800, name: TABLET),
            ResponsiveBreakpoint.resize(906, name: "LARGERTABLET"),
            ResponsiveBreakpoint.resize(1100, name: "SMALLERDESKTOP"),
            ResponsiveBreakpoint.resize(1300, name: DESKTOP),
            ResponsiveBreakpoint.resize(1560, name: "LARGERDESKTOP"),
            ResponsiveBreakpoint.resize(1650, name: "MEDIUMDESKTOP"),
            ResponsiveBreakpoint.resize(1808, name: "SERVINGYOURVISION2"),
            ResponsiveBreakpoint.resize(3000, name: 'LARGESTDESKTOP'),
          ],
        ),
        debugShowCheckedModeBanner: false,
        routeInformationProvider: RoutesManager.router.routeInformationProvider,
        routeInformationParser: RoutesManager.router.routeInformationParser,
        routerDelegate: RoutesManager.router.routerDelegate,
      );
}

import 'package:flutter/material.dart';
import 'package:audima/presentaion/resources/routes_manager.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatefulWidget {
  //named constructor
  App._internal();
  int appState = 0;
  static final App _instance = App._internal();

  factory App() {
    return _instance;
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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

        //   initialRoute: '/',
        // routes: {
        //   '/': (context) {
        //     initLoginModule();
        //     return LoginView();
        //   },
        //   '/login': (context) {
        //     initLoginModule();
        //     return LoginView();
        //   },
        //   '/home': (context) {
        //     return HomeView();
        //   },
        // },
      );
}

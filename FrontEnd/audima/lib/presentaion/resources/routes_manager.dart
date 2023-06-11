import 'package:audima/app/app_prefrences.dart';
import 'package:audima/app/constants.dart';
import 'package:audima/app/di.dart';
import 'package:audima/presentaion/business_video/view/business_video_view.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/final_presentation/view/final_presentation_view.dart';
import 'package:audima/presentaion/login/view/login_view.dart';
import 'package:audima/presentaion/mission_statement/view/mission_statement_view.dart';
import 'package:audima/presentaion/onboarding/onboarding.dart';
import 'package:audima/presentaion/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../business_info/view/business_info_view.dart';
import '../home/home_view.dart';

class Routes {
  static const String splash = "/";
  static const String onBoarding = "/on-boarding";
  static const String home = "/home";
  static const String businessInfo = "/business-info";
  static const String missionStatement = "/mission-statement";
  static const String businessVideo = "/business-video";
  static const String finalPresentation = "/final-presentation";
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => OnBoardingView());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.businessInfo:
        initBusinessInfoModule();
        return MaterialPageRoute(builder: (_) => BusinessInfo());
      case Routes.missionStatement:
        if (arguments is BusinessInfoObject) {
          initMissionStatementModule();
          return MaterialPageRoute(
              builder: (_) =>
                  MissionStatementView(businessInfoObject: arguments));
        } else {
          // Handle the case when arguments are null or of the wrong type
          // For example, navigate back to a fallback screen
          return MaterialPageRoute(builder: (_) => HomeView());
        }
      case Routes.businessVideo:
        initVideoUploadModule();
        return MaterialPageRoute(builder: (_) => BusinessVideo());
      case Routes.finalPresentation:
        initFinalPresentationModule();
        return MaterialPageRoute(builder: (_) => FinalPresentationView());
      default:
        return MaterialPageRoute(builder: (_) => HomeView());
    }
  }
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class RoutesManager {
  AppPreferences _appPreferences = instance<AppPreferences>();
  static final GoRouter router = GoRouter(
      urlPathStrategy: UrlPathStrategy.path,
      navigatorKey: navKey,
      routes: <GoRoute>[
        GoRoute(
            name: "splash",
            path: '/',
            pageBuilder: (context, state) {
              // initVideoUploadModule();
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: SplashView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(milliseconds: 500),
              );
            }),
        GoRoute(
          name: "home",
          path: '/home',
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: HomeView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        ),
        // GoRoute(
        //     name: "login",
        //     path: '/login',
        //     pageBuilder: (context, state) {
        //       initLoginModule();
        //       return CustomTransitionPage<void>(
        //         key: state.pageKey,
        //         child: LoginView(),
        //         transitionsBuilder:
        //             (context, animation, secondaryAnimation, child) =>
        //                 FadeTransition(opacity: animation, child: child),
        //         transitionDuration: const Duration(milliseconds: 500),
        //       );
        //     }),
        GoRoute(
            name: "business-info",
            path: '/business-info',
            pageBuilder: (context, state) {
              initBusinessInfoModule();
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: BusinessInfo(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(milliseconds: 500),
              );
            }),
        GoRoute(
            name: "mission-statement",
            path: '/mission-statement',
            // redirect: ((state) {
            //   if (Constants.BusinessInfoScreenViewStatus == false) {
            //     return "/business-info";
            //   }
            // }),
            pageBuilder: (context, state) {
              initMissionStatementModule();
              BusinessInfoObject businessInfoObject =
                  state.extra as BusinessInfoObject;
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: MissionStatementView(
                    businessInfoObject: businessInfoObject),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(milliseconds: 500),
              );
            }),
        GoRoute(
            name: "business-video",
            path: '/business-video',
            pageBuilder: (context, state) {
              initVideoUploadModule();
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: BusinessVideo(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(milliseconds: 500),
              );
            }),
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(
            child: Scaffold(body: Center(child: Text("Url Not Found"))));
      });
}

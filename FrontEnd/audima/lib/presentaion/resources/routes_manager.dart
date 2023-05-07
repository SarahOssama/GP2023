import 'package:audima/app/app_prefrences.dart';
import 'package:audima/app/constants.dart';
import 'package:audima/app/di.dart';
import 'package:audima/presentaion/business_video/view/business_video_view.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/login/view/login_view.dart';
import 'package:audima/presentaion/mission_statement/view/mission_statement_view.dart';
import 'package:audima/presentaion/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../business_info/view/business_info_view.dart';
import '../home/home_view.dart';

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
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: SplashView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          );
          }
        ),
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
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: BusinessInfo(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        ),
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
          }
        ),
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(
            child: Scaffold(body: Center(child: Text("Url Not Found"))));
      });
}

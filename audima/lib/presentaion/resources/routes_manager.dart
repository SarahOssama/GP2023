import 'package:audima/app/di.dart';
import 'package:audima/presentaion/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../business_info/view/business_info_view.dart';
import '../home/home_view.dart';

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

// class RouterGenerator{
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (_) => HomeView());
//       case '/login':
//         return MaterialPageRoute(builder: (_) => LoginView());
//       case '/business-info':
//         return MaterialPageRoute(builder: (_) => BusinessInfo());
//       default:
//         return MaterialPageRoute(builder: (_) => Scaffold(
//           body: Center(child: Text('No route defined for ${settings.name}')),
//         ));
//     }
//   }
// }
class RoutesManager {
  static final GoRouter router = GoRouter(
      urlPathStrategy: UrlPathStrategy.path,
      navigatorKey: navKey,
      routes: <GoRoute>[
        GoRoute(
          name: "home",
          path: '/',
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: HomeView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        ),
        GoRoute(
            name: "login",
            path: '/login',
            pageBuilder: (context, state) {
              initLoginModule();
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: LoginView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(milliseconds: 500),
              );
            }),
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
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(
            child: Scaffold(body: Center(child: Text("Url Not Found"))));
      });
}

import 'package:audima/presentaion/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:audima/presentaion/main_view/main_view.dart';
import 'package:audima/presentaion/products/diagnostics&specialist/diagnostics_specialist_view.dart';
import 'package:audima/presentaion/products/imaging_systems/imaging_systems_view.dart';
import 'package:audima/presentaion/products/operating_microscopes/operating_microscopes_view.dart';
import 'package:audima/presentaion/products/opthalmic_furnitures/opthalmic_furnitures_view.dart';

import '../about_us/about_us_view.dart';
import '../business_info/view/business_info_view.dart';
import '../contact_us/contact_us_view.dart';
import '../home/home_view.dart';
import '../products/products_view.dart';
import '../products/slit_lamp_microscopes/slit_lamp_microscopes_view.dart';
import 'assets_manager.dart';

class RoutesManager {
  static final GoRouter router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => LoginView(),
        routes: <GoRoute>[
          GoRoute(
            path: 'login',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: LoginView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
              transitionDuration: const Duration(milliseconds: 500),
            ),
          ),
          GoRoute(
            path: 'home',
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
            path: 'business-info',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const BusinessInfo(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
              transitionDuration: const Duration(milliseconds: 500),
            ),
          ),
          // GoRoute(
          //     path: 'products',
          //     pageBuilder: (context, state) => CustomTransitionPage<void>(
          //           key: state.pageKey,
          //           child: MainView(
          //             sideMenuKey: GlobalKey<SideMenuState>(),
          //             bodyView: const ProductsView(),
          //             index: 1,
          //           ),
          //           transitionsBuilder:
          //               (context, animation, secondaryAnimation, child) =>
          //                   FadeTransition(opacity: animation, child: child),
          //           transitionDuration: const Duration(milliseconds: 500),
          //         ),
          //     routes: <GoRoute>[
          //       GoRoute(
          //         path: SlitLampMicroscopes().pathName,
          //         pageBuilder: (context, state) => CustomTransitionPage<void>(
          //           key: state.pageKey,
          //           child: MainView(
          //             sideMenuKey: GlobalKey<SideMenuState>(),
          //             bodyView: const SlitLampMicroscopesView(),
          //             index: 1,
          //           ),
          //           transitionsBuilder:
          //               (context, animation, secondaryAnimation, child) =>
          //                   FadeTransition(opacity: animation, child: child),
          //           transitionDuration: const Duration(milliseconds: 500),
          //         ),
          //       ),
          //       GoRoute(
          //         path: OperatingMicroscopes().pathName,
          //         pageBuilder: (context, state) => CustomTransitionPage<void>(
          //           key: state.pageKey,
          //           child: MainView(
          //             sideMenuKey: GlobalKey<SideMenuState>(),
          //             bodyView: const OperatingMicroscopesView(),
          //             index: 1,
          //           ),
          //           transitionsBuilder:
          //               (context, animation, secondaryAnimation, child) =>
          //                   FadeTransition(opacity: animation, child: child),
          //           transitionDuration: const Duration(milliseconds: 500),
          //         ),
          //       ),
          //       GoRoute(
          //         path: ImagingSystems().pathName,
          //         pageBuilder: (context, state) => CustomTransitionPage<void>(
          //           key: state.pageKey,
          //           child: MainView(
          //             sideMenuKey: GlobalKey<SideMenuState>(),
          //             bodyView: const ImagingSystemsView(),
          //             index: 1,
          //           ),
          //           transitionsBuilder:
          //               (context, animation, secondaryAnimation, child) =>
          //                   FadeTransition(opacity: animation, child: child),
          //           transitionDuration: const Duration(milliseconds: 500),
          //         ),
          //       ),
          //       GoRoute(
          //         path: DiagnosticsAndSpecialist().pathName,
          //         pageBuilder: (context, state) => CustomTransitionPage<void>(
          //           key: state.pageKey,
          //           child: MainView(
          //             sideMenuKey: GlobalKey<SideMenuState>(),
          //             bodyView: const DiagnosticsAndSpecialistView(),
          //             index: 1,
          //           ),
          //           transitionsBuilder:
          //               (context, animation, secondaryAnimation, child) =>
          //                   FadeTransition(opacity: animation, child: child),
          //           transitionDuration: const Duration(milliseconds: 500),
          //         ),
          //       ),
          //       GoRoute(
          //         path: OpthalmicFurnitures().pathName,
          //         pageBuilder: (context, state) => CustomTransitionPage<void>(
          //           key: state.pageKey,
          //           child: MainView(
          //             sideMenuKey: GlobalKey<SideMenuState>(),
          //             bodyView: const OpthalmicFurnituresView(),
          //             index: 1,
          //           ),
          //           transitionsBuilder:
          //               (context, animation, secondaryAnimation, child) =>
          //                   FadeTransition(opacity: animation, child: child),
          //           transitionDuration: const Duration(milliseconds: 500),
          //         ),
          //       ),
          //     ]),
          // GoRoute(
          //   path: 'aboutUs',
          //   pageBuilder: (context, state) => CustomTransitionPage<void>(
          //     key: state.pageKey,
          //     child: MainView(
          //       sideMenuKey: GlobalKey<SideMenuState>(),
          //       bodyView: AboutUsView(),
          //       index: 2,
          //     ),
          //     transitionsBuilder:
          //         (context, animation, secondaryAnimation, child) =>
          //             FadeTransition(opacity: animation, child: child),
          //     transitionDuration: const Duration(milliseconds: 500),
          //   ),
          // ),
          // GoRoute(
          //   path: 'contactUs',
          //   pageBuilder: (context, state) => CustomTransitionPage<void>(
          //     key: state.pageKey,
          //     child: MainView(
          //       sideMenuKey: GlobalKey<SideMenuState>(),
          //       bodyView: const ContactUsView(),
          //       index: 3,
          //     ),
          //     transitionsBuilder:
          //         (context, animation, secondaryAnimation, child) =>
          //             FadeTransition(opacity: animation, child: child),
          //     transitionDuration: const Duration(milliseconds: 500),
          //   ),
          // ),
        ],
      ),
    ],
  );
}

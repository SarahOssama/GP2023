// ignore_for_file: prefer_const_constructors

import 'package:audima/app/app_prefrences.dart';
import 'package:audima/app/di.dart';
import 'package:audima/presentaion/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/responsive.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  // Controllers

  @override
  void initState() {
    _appPreferences.setHomeScreenViewed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Audima',
            style: ResponsiveTextStyles.audima(context),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/home.jpg'),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 120,
                  backgroundImage: AssetImage('assets/images/audimalogo.png'),
                ),
                SizedBox(
                  height: 100,
                ),
                Shimmer(
                  duration: const Duration(milliseconds: 1500),
                  color: Color.fromARGB(255, 63, 4, 0),
                  colorOpacity: 1,
                  child: SizedBox(
                    height: 40,
                    width: 250,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.businessInfo);
                      },
                      child: CustomizedText(
                          text: "Start Your Business Journey",
                          textStyle:
                              ResponsiveTextStyles.startYourBusinessJourney(
                                  context)),
                    ),
                  ),
                ),
              ],
            ),

            // Container(
            //   width: 400,
            //   height: 300,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       fit: BoxFit.cover,
            //       image: AssetImage('assets/images/audimalogo.png'),
            //     ),
            //   ),
            // ),

            // ResponsiveVisibility(
            //   hiddenWhen: const [Condition.smallerThan(name: MOBILE)],
            //   child: Positioned.fill(
            //     child: Padding(
            //       padding: EdgeInsets.only(
            //         left: ResponsiveValues.servingYourVisionLeftPadding(context),
            //         bottom:
            //             ResponsiveValues.servingYourVisionBottomPadding(context),
            //       ),
            //       child: Align(
            //         alignment: Alignment.centerLeft,
            //         child: CustomizedTextNotCentered(
            //           text: 'Start Your Business Journey',
            //           textStyle: ResponsiveTextStyles.servingYourVisionLargerStyle(
            //               context),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // ResponsiveVisibility(
            //   visible: false,
            //   visibleWhen: const [Condition.smallerThan(name: MOBILE)],
            //   child: Positioned.fill(
            //     child: Padding(
            //       padding: const EdgeInsets.only(right: 7),
            //       child: Align(
            //         alignment: Alignment.bottomRight,
            //         child: CustomizedTextNotCentered(
            //           text: 'Start Your Business Journey',
            //           textStyle: ResponsiveTextStyles.servingYourVisionSmallerStyle(
            //               context),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}

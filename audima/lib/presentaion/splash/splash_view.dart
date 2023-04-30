import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audima/app/app_prefrences.dart';
import 'package:audima/app/di.dart';
import 'package:audima/responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

AppPreferences _appPreferences = instance<AppPreferences>();

class _SplashViewState extends State<SplashView> {
  _goNext() {
    context.go("/home");
    // _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
    //   if (isUserLoggedIn) {
    //     //navigate to business info
    //     context.push('/business-info');
    //   } else {

    //   }
    // });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), _goNext);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedTextKit(animatedTexts: [
          //create the other animated texts here
          RotateAnimatedText(
            'Audima',
            textStyle: ResponsiveTextStyles.audimaSplash(context),
          ),
        ]),
      ),
    );
  }
}

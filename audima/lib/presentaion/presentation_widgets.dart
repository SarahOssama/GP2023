import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

import 'package:responsive_framework/responsive_framework.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/presentaion/resources/colors_manager.dart';
import 'package:audima/responsive.dart';

// launchTmicoLinkedinURL() async {
//   const url = 'https://www.linkedin.com/company/tmicoegy';
//   if (await canLaunchUrlString(url)) {
//     await launchUrlString(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

Widget mainTabBar(BuildContext context, Color color) {
  return Container(
    color: color,
    child: Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                'Audima',
                style: ResponsiveTextStyles.audima(context),
              ),
              // CircleAvatar(
              //   radius: ResponsiveValues.tmicoLogoRadius(context),
              //   backgroundImage: const NetworkImage(TmicoImages.tmicoLogo),
              // ),
            ],
          ),
        ),
      ],
    ),
  );
}

class ScrollingWidget extends StatelessWidget {
  final ScrollController scrollController;
  final ListView child;
  const ScrollingWidget(
      {super.key, required this.child, required this.scrollController});
  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
      visible: false,
      visibleWhen: const [Condition.largerThan(name: TABLET)],
      replacement:
          DraggableScrollbar.rrect(controller: scrollController, child: child),
      child: AdaptiveScrollbar(
          sliderDefaultColor: ColorsManager.inActiveScrollBarColor,
          sliderActiveColor: ColorsManager.activeScrollBarColor,
          controller: scrollController,
          child: ImprovedScrolling(
            scrollController: scrollController,
            enableCustomMouseWheelScrolling: true,
            enableKeyboardScrolling: true,
            child: child,
          )),
    );
  }
}

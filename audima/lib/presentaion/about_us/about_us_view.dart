import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:audima/presentaion/about_us/about_us_widgets.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/responsive.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../presentation_widgets.dart';

class AboutUsView extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  AboutUsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ScrollingWidget(
      scrollController: scrollController,
      child: ListView(
        controller: scrollController,
        children: [
          SizedBox(
            width: double.infinity,
            height: ResponsiveValues.aboutUsMainImageHeight(context),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  OtherImages.aboutImage,
                  color: Colors.black.withOpacity(0.4),
                  colorBlendMode: BlendMode.darken,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                    left: ResponsiveValue(context,
                        defaultValue: 200.0,
                        valueWhen: [
                          const Condition.smallerThan(
                            name: "LARGERDESKTOP",
                            value: 180.0,
                          ),
                          const Condition.smallerThan(
                            name: DESKTOP,
                            value: 140.0,
                          ),
                          const Condition.smallerThan(
                            name: "SMALLERDESKTOP",
                            value: 100.0,
                          ),
                          const Condition.smallerThan(
                            name: "LARGERTABLET",
                            value: 50.0,
                          ),
                          const Condition.smallerThan(
                              name: MOBILE, value: 34.0),
                          const Condition.smallerThan(
                              name: "SMALLERMOBILE", value: 20.0),
                          const Condition.smallerThan(
                              name: "SMALLESTMOBILE", value: 10.0)
                        ]).value,
                    bottom: MediaQuery.of(context).size.width < 358 ? 50 : 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomizedTextNotCentered(
                          text: "About Us",
                          textStyle: ResponsiveTextStyles.aboutUsStyle(context),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: ResponsiveValues.aboutUsSecondrylineWidth(
                              context),
                          child: CustomizedTextNotCentered(
                            text:
                                "We are a Trustworthy Meticulous and Ingenuity team, Who Contribute to the welfare of our Origin Egypt.",
                            textStyle:
                                ResponsiveTextStyles.startYourBusinessJourney(
                                    context),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            height: 400,
            width: double.infinity,
            color: Colors.grey.shade300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomizedText(
                    text: "Our Vision",
                    textStyle: ResponsiveTextStyles.ourStoryStyle(context)),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  width: 500,
                  child: CustomizedText(
                      text:
                          "Sales and Marketing of high standards medical devices and Consumables by a trustworthy, meticulous and Ingenuity team to become one of the leading Companies by inspiring our strength from the top level of Customer satisfaction and pursuing the highest level of medical devices and Consumables",
                      textStyle:
                          ResponsiveTextStyles.ourStorySecondryStyle(context)),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 200,
          ),
          ResponsiveRowColumn(
            columnSpacing: 50,
            layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            children: const [
              ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: AboutUsDataContainer(
                      image: OtherImages.about1Image,
                      text1: "FIND YOU THE PERFECT EQUIPMENT",
                      text2:
                          "Serving your needs is what we look forward to accordingly we will equip you with the best products to extend your business to the limits.")),
              ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: AboutUsDataContainer(
                      image: OtherImages.about2Image,
                      text1: "WORK WITH YOUR BUDGET",
                      text2:
                          "Our products are well known for their high quality and efficiency also we are selling it in a flexible manner to work out with your budget.")),
              ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: AboutUsDataContainer(
                      image: OtherImages.about3Image,
                      text1: "MAINTAIN YOUR DEVICE FOR GOOD",
                      text2:
                          "Our concern is to keep you satisifed with our products experience accordingly we are providing you with full maintainance for our products")),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            height: ResponsiveValues.ourTeamContainerHeight(context),
            width: double.infinity,
            color: Colors.grey.shade300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomizedText(
                    text: "Our Story",
                    textStyle: ResponsiveTextStyles.ourStoryStyle(context)),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 500,
                  child: CustomizedText(
                      text:
                          "Tmico Established in Cairo-Egypt on 2021 by a group of a highly professionals who were being working for the last 26 years in one of the leading Distribution companies in the Middle East,Tmico engages in Sales, Marketing & service Engineering of Medical Equipment & Consumables in the Egyptian Market.",
                      textStyle:
                          ResponsiveTextStyles.ourStorySecondryStyle(context)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: MediaQuery.of(context).size.width < 450
                        ? const EdgeInsets.symmetric(horizontal: 0)
                        : const EdgeInsets.symmetric(horizontal: 50),
                    width: 800,
                    height: ResponsiveValues.ourTeamHeight(context),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      child: Image.network(
                        OtherImages.team,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          SizedBox(
            width: double.infinity,
            height: ResponsiveValues.aboutUsMainImageHeight(context),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  OtherImages.aboutImage,
                  color: Colors.black.withOpacity(0.4),
                  colorBlendMode: BlendMode.darken,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  left: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: CustomizedTextNotCentered(
                            text: "Get Started Equipping Your Business",
                            textStyle:
                                ResponsiveTextStyles.getStartedStyle(context),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Shimmer(
                          duration: const Duration(seconds: 2),
                          colorOpacity: 0.5,
                          child: SizedBox(
                            width: ResponsiveValues.aboutUsBrowseProductsWidth(
                                context),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.only(top: 12, bottom: 18)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              onPressed: () {
                                context.go("/products");
                              },
                              child: CustomizedText(
                                  text: "Browse Products",
                                  textStyle: ResponsiveTextStyles
                                      .startYourBusinessJourney(context)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:audima/responsive.dart';

import '../resources/assets_manager.dart';

List products = [
  SlitLampMicroscopes(),
  OperatingMicroscopes(),
  ImagingSystems(),
  DiagnosticsAndSpecialist(),
  OpthalmicFurnitures(),
];
List<DeviceOnImageText> imagesTexts = [
  DeviceOnImageText(
      headLine: "Slit Lamp Microscopes",
      parag:
          "From cornea to retina we have a slit lamp system to suit your diagnostic needs with world renowned optical capability and unique styling"),
  DeviceOnImageText(
      headLine: "Operating Microscopes",
      parag:
          "Versatile microscope systems suitable for anterior and posterior surgery procedures with crystal clear apochromatic optics"),
  DeviceOnImageText(
      headLine: "Imaging Systems",
      parag:
          "Full HD and medical grade systems for slit lamps and operating microscopes, with patient software, and tailored to your exacting requirements"),
  DeviceOnImageText(
      headLine: "Diagnostic & Specialist",
      parag:
          "From contrast and glare sensitivity measurement through to refractive examination devices, we provide accuracy and reliability"),
  DeviceOnImageText(
      headLine: "Ophthalmic Furniture",
      parag:
          "Using only high quality medical grade materials our chairs, tables, and examination units are built to last, designed for the most demanding of clinical environments"),
];

class DeviceOnImageText {
  String headLine;
  String parag;
  DeviceOnImageText({required this.headLine, required this.parag});
}

//this in products section to build images of our categories
class BuildOurProdcutsImages extends StatelessWidget {
  final String imageUrl;
  final int imageIndex;
  final String productPathName;
  const BuildOurProdcutsImages(
      {super.key,
      required this.imageUrl,
      required this.imageIndex,
      required this.productPathName});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/products/$productPathName');
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffE5E5E5),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              ResponsiveValues.productImageRadius(
                context,
              ),
            ),
            bottomRight: Radius.circular(
              ResponsiveValues.productImageRadius(
                context,
              ),
            ),
          ),
        ),

        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        //make the card to open the image to full screen when got pressed
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  ResponsiveValues.productImageRadius(
                    context,
                  ),
                ),
              ),
              child: Image.network(
                imageUrl,
                color: Colors.black.withOpacity(0.5),
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget productsTabBar(BuildContext context, Color color,
    final TabController tabController, CarouselController carouselController) {
  return Container(
    height: 45,
    decoration: BoxDecoration(
        color: color, borderRadius: const BorderRadius.all(Radius.circular(5))),
    child: Center(
      child: TabBar(
        onTap: (index) {
          carouselController.animateToPage(tabController.index);
        },
        isScrollable: true,
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black,
        labelPadding: EdgeInsets.only(
          left: ResponsiveValues.productTabBarLabelLeftPadding(context),
          right: ResponsiveValues.productTabBarLabelrightPadding(context),
        ),
        unselectedLabelColor: Colors.black.withOpacity(0.5),
        indicatorColor: Colors.black,
        tabs: [
          Text(
            'Slit Lamp Microscopes',
            style: ResponsiveTextStyles.productTabsStyle(context),
          ),
          Text(
            'Operating Microscopes',
            style: ResponsiveTextStyles.productTabsStyle(context),
          ),
          Text(
            'Imaging Systems',
            style: ResponsiveTextStyles.productTabsStyle(context),
          ),
          Text(
            'Diagnostics & Specialist',
            style: ResponsiveTextStyles.productTabsStyle(context),
          ),
          Text(
            'Opthalamic Furniture',
            style: ResponsiveTextStyles.productTabsStyle(context),
          ),
        ],
      ),
    ),
  );
}

//for every product category there are some products card which will be rendered by this widget
class BuildCategoriesImages extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String path;
  const BuildCategoriesImages(
      {super.key,
      required this.imageUrl,
      required this.path,
      required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          ResponsiveRowColumn(
            rowMainAxisAlignment: MainAxisAlignment.center,
            layout: ResponsiveWrapper.of(context).isSmallerThan("LARGERTABLET")
                ? ResponsiveRowColumnType.ROW
                : ResponsiveRowColumnType.COLUMN,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: InkWell(
                  hoverColor: Colors.black,
                  borderRadius: BorderRadius.circular(30.0),
                  onTap: () {
                    context.go('/products/$path');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.network(
                      imageUrl,
                      color: Colors.white.withOpacity(0.5),
                      colorBlendMode: BlendMode.modulate,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: SizedBox(
                  height: ResponsiveValue(
                    context,
                    defaultValue: 20.0,
                    valueWhen: [
                      const Condition.smallerThan(
                        name: "LARGERTABLET",
                        value: 30.0,
                      )
                    ],
                  ).value,
                  width: ResponsiveValue(
                    context,
                    defaultValue: 20.0,
                    valueWhen: [
                      const Condition.smallerThan(
                        name: "LARGERTABLET",
                        value: 30.0,
                      )
                    ],
                  ).value,
                ),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: InkWell(
                  onTap: () {
                    context.go('/products/$path');
                  },
                  child: CustomizedText(
                      text: text,
                      textStyle: ResponsiveTextStyles.categoriesStyle(context)),
                ),
              ),
            ],
          ),
          const ResponsiveVisibility(
              visible: false,
              visibleWhen: [Condition.smallerThan(name: "LARGERTABLET")],
              child: SizedBox(
                height: 100,
              ))
        ],
      ),
    );
  }
}

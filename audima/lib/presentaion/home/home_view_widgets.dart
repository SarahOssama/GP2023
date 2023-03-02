import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:audima/presentaion/resources/strings_manager.dart';
import 'package:audima/responsive.dart';

import '../resources/assets_manager.dart';

List images = [
  SlitLampMicroscopesImages.slitLamp,
  SlitLampMicroscopesImages.slitLamp30GLFront,
  SlitLampMicroscopesImages.slitLamp30GLSide,
  SlitLampMicroscopesImages.slitLamp700GL,
  SlitLampMicroscopesImages.slitLamp700GLBlur,
  SlitLampMicroscopesImages.at1,
  SlitLampMicroscopesImages.ms1,
  OperatingMicroscopesImages.om19,
  OperatingMicroscopesImages.om6,
  OperatingMicroscopesImages.om6Blur,
  OperatingMicroscopesImages.om9,
  OperatingMicroscopesImages.om9Blur,
  ImagingSystemsImages.dis1,
  ImagingSystemsImages.td10,
  DiagnosticsAndSpecialistImages.arkmBack,
  DiagnosticsAndSpecialistImages.arkmThumb,
  DiagnosticsAndSpecialistImages.cp40Front,
  DiagnosticsAndSpecialistImages.cp40Side,
  DiagnosticsAndSpecialistImages.mt266,
  DiagnosticsAndSpecialistImages.smTube,
  DiagnosticsAndSpecialistImages.snt700BlurView,
  DiagnosticsAndSpecialistImages.snt700CloseView,
  DiagnosticsAndSpecialistImages.snt700FrontView,
  DiagnosticsAndSpecialistImages.snt700lensView,
  DiagnosticsAndSpecialistImages.tf600,
  DiagnosticsAndSpecialistImages.vt5,
  DiagnosticsAndSpecialistImages.vt5Blury,
  OpthalmicFurnituresImages.deltaQ,
  OpthalmicFurnituresImages.mds14,
  OpthalmicFurnituresImages.zulu1,
  OpthalmicFurnituresImages.zulu2,
  OpthalmicFurnituresImages.zulu3
];
Widget imageDialog(text, path, context) {
  return Dialog(
    // backgroundColor: Colors.transparent,
    child: Image.network(
      '$path',
      fit: BoxFit.cover,
    ),
  );
}

class BuildOurOfferingsImage extends StatelessWidget {
  final String imageUrl;
  final int imageIndex;
  const BuildOurOfferingsImage(
      {super.key, required this.imageUrl, required this.imageIndex});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurStyle: BlurStyle.inner,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2, 0), // shadow direction: bottom right
              ),
              BoxShadow(
                color: Colors.black,
                blurStyle: BlurStyle.inner,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(0, 2), // shadow direction: bottom right
              ),
            ],
          ),
          //make the card to open the image to full screen when got pressed
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => imageDialog('My Image', imageUrl, context));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OurOfferings extends StatelessWidget {
  const OurOfferings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomizedText(
          text: "Our Services",
          textStyle: ResponsiveTextStyles.ourServicesStyle(context),
        ),
        const SizedBox(
          height: 50,
        ),
        //here to put the crusole slider of machines images
        CarouselSlider.builder(
          itemCount: images.length,
          options: CarouselOptions(
              viewportFraction: ResponsiveValues.homeSliderViewPort(context),
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              height: ResponsiveValues.homeSliderHeight(context),
              aspectRatio: 1.5,
              autoPlay: true),
          itemBuilder: (context, index, realIndex) {
            final urlImage = images[index];
            return BuildOurOfferingsImage(
                imageUrl: urlImage, imageIndex: index);
          },
        ),
        const SizedBox(
          height: 100,
        ),
        const Services(),
      ],
    );
  }
}

class Service extends StatelessWidget {
  final IconData iconName;
  final String firstText;
  final String secondText;
  const Service(
      {super.key,
      required this.firstText,
      required this.iconName,
      required this.secondText});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(
            iconName,
            size: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomizedText(
          text: firstText,
          textStyle: ResponsiveTextStyles.servicesHeadlineStyle(context),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomizedText(
          text: secondText,
          textStyle: ResponsiveTextStyles.servicesSecondrylineStyle(context),
        ),
      ],
    );
  }
}

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveValues.servicesContainerHeight(context),
      color: const Color.fromARGB(255, 5, 25, 52),
      child: Column(
        children: [
          ResponsiveRowColumn(
            layout:
                ResponsiveWrapper.of(context).isSmallerThan("SMALLERDESKTOP")
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: Service(
                    firstText: StringsManager.firstOfferingHeadLine,
                    iconName: Icons.add_shopping_cart,
                    secondText: StringsManager.firstOfferingDetailed),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: Service(
                    firstText: StringsManager.secondOfferingHeadLine,
                    iconName: Icons.attach_money,
                    secondText: StringsManager.secondOfferingDetailed),
              ),
            ],
          ),
          ResponsiveRowColumn(
            layout:
                ResponsiveWrapper.of(context).isSmallerThan("SMALLERDESKTOP")
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: Service(
                    firstText: StringsManager.thirdOfferingHeadLine,
                    iconName: Icons.call,
                    secondText: StringsManager.thirdOfferingDetailed),
              ),
              const ResponsiveRowColumnItem(
                rowFlex: 1,
                child: Service(
                    firstText: "Maintainance",
                    iconName: FontAwesomeIcons.wrench,
                    secondText:
                        "Our concern is to keep you satisifed with our products experience accordingly\n we are providing you with full maintainance for our products"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

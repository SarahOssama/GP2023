import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/responsive.dart';

List slitlampMicroscopes = [
  SGL700(),
  SGL700NSW(),
  SGL30(),
  SMS1(),
  SAT1(),
];
List operatingMicroscopes = [
  OOM6(),
  OOM9(),
  OOM19(),
];
List imagingSystems = [
  IDIS1(),
  ITD10(),
];
List diagnosticsAndSpecialist = [
  DACCUON(),
  DARKM150(),
  DCP40(),
  DMT266(),
  DSMTUBE(),
  DSNT700(),
  DTF600(),
  DVT5(),
];
List opthalmicFurnitures = [
  FDrone4(),
  FDeltaQ(),
  FMDS14(),
  FMDS14S(),
  FZULU1(),
  FZULU2(),
  FZULU3()
];

class ProductContainer extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productViewingData;
  final String productPath;
  final CarouselController carouselController;
  const ProductContainer(
      {super.key,
      required this.productImage,
      required this.productName,
      required this.productViewingData,
      required this.productPath,
      required this.carouselController});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: IconButton(
            iconSize: 60,
            icon: Icon(
              FontAwesomeIcons.angleLeft,
              color: Colors.grey,
              size: ResponsiveValue(context, defaultValue: 60.0, valueWhen: [
                const Condition.smallerThan(
                  name: MOBILE,
                  value: 30.0,
                )
              ]).value,
            ),
            onPressed: () {
              carouselController.previousPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.ease);
            },
          ),
        ),
        Expanded(
          flex: MediaQuery.of(context).size.width < 1100 ? 5 : 4,
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 152, 176, 187),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: ResponsiveRowColumn(
              columnPadding: const EdgeInsets.only(top: 30, bottom: 50),
              layout:
                  ResponsiveWrapper.of(context).isSmallerThan("LARGERTABLET")
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
              children: [
                ResponsiveRowColumnItem(
                  columnFlex: 1,
                  rowFlex: 1,
                  columnOrder: 2,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: Image.network(
                          productImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  columnOrder: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomizedText(
                            text: productName,
                            textStyle:
                                ResponsiveTextStyles.insideProductHeadlineStyle(
                                    context)),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomizedText(
                            text: productViewingData,
                            textStyle: ResponsiveTextStyles
                                .insideProductSecondrylineStyle(context)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: IconButton(
            iconSize: 60,
            icon: Icon(
              FontAwesomeIcons.angleRight,
              color: Colors.grey,
              size: ResponsiveValue(context, defaultValue: 60.0, valueWhen: [
                const Condition.smallerThan(
                  name: MOBILE,
                  value: 30.0,
                )
              ]).value,
            ),
            onPressed: () {
              carouselController.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.ease);
            },
          ),
        ),
      ],
    );
  }
}

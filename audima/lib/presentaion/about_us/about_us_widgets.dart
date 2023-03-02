import 'package:flutter/material.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/responsive.dart';

class AboutUsDataContainer extends StatelessWidget {
  final String image;
  final String text1;
  final String text2;
  const AboutUsDataContainer(
      {super.key,
      required this.image,
      required this.text1,
      required this.text2});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          width: ResponsiveValues.aboutUsDataContainerwidth(context),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomizedText(
            text: text1,
            textStyle:
                ResponsiveTextStyles.aboutUsDataContainerStyle1(context)),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 300,
          child: CustomizedText(
              text: text2,
              textStyle:
                  ResponsiveTextStyles.aboutUsDataContainerStyle2(context)),
        ),
      ],
    );
  }
}

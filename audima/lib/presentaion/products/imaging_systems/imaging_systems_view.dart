import 'package:flutter/material.dart';
import 'package:audima/presentaion/products/product_inside_products/product_inside_products_view.dart';
import 'package:audima/presentaion/products/products_widgets/products_widgets.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/responsive.dart';

class ImagingSystemsView extends StatelessWidget {
  const ImagingSystemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductInsideProductsView(
      customizedTextHeadline: CustomizedText(
          text: "Imaging Systems",
          textStyle: ResponsiveTextStyles.productHeadLineStyle(context)),
      customizedTextSecondrline: CustomizedText(
          text:
              "Full HD and medical grade systems for slit lamps and operating microscopes, with patient software, and tailored to your exacting requirements.",
          textStyle: ResponsiveTextStyles.productSecondrylineStyle(context)),
      productsList: imagingSystems,
    );
  }
}

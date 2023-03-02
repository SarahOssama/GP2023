import 'package:flutter/material.dart';
import 'package:audima/presentaion/products/product_inside_products/product_inside_products_view.dart';
import 'package:audima/presentaion/products/products_widgets/products_widgets.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/responsive.dart';

class OperatingMicroscopesView extends StatelessWidget {
  const OperatingMicroscopesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductInsideProductsView(
      customizedTextHeadline: CustomizedText(
          text: "Operating Microscopes",
          textStyle: ResponsiveTextStyles.productHeadLineStyle(context)),
      customizedTextSecondrline: CustomizedText(
          text:
              "Versatile microscope systems suitable for anterior and posterior surgery procedures with crystal clear optics.",
          textStyle: ResponsiveTextStyles.productSecondrylineStyle(context)),
      productsList: operatingMicroscopes,
    );
  }
}

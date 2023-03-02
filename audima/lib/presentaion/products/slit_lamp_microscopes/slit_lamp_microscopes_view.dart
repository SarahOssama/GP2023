import 'package:flutter/material.dart';
import 'package:audima/presentaion/products/product_inside_products/product_inside_products_view.dart';
import 'package:audima/presentaion/products/products_widgets/products_widgets.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/responsive.dart';

class SlitLampMicroscopesView extends StatelessWidget {
  const SlitLampMicroscopesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductInsideProductsView(
      customizedTextHeadline: CustomizedText(
          text: "Slit Lamp Microscopes",
          textStyle: ResponsiveTextStyles.productHeadLineStyle(context)),
      customizedTextSecondrline: CustomizedText(
          text:
              "From cornea to retina we have a slit lamp system to suit your diagnostic needs with world renowned optical capability and unique styling.",
          textStyle: ResponsiveTextStyles.productSecondrylineStyle(context)),
      productsList: slitlampMicroscopes,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:audima/presentaion/products/product_inside_products/product_inside_products_view.dart';
import 'package:audima/presentaion/products/products_widgets/products_widgets.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/responsive.dart';

class OpthalmicFurnituresView extends StatelessWidget {
  const OpthalmicFurnituresView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductInsideProductsView(
      customizedTextHeadline: CustomizedText(
          text: "Ophthalmic Furniture",
          textStyle: ResponsiveTextStyles.productHeadLineStyle(context)),
      customizedTextSecondrline: CustomizedText(
          text:
              "Using only high quality medical grade materials our chairs, tables, and examination units are built to last, designed for the most demanding of clinical environments.",
          textStyle: ResponsiveTextStyles.productSecondrylineStyle(context)),
      productsList: opthalmicFurnitures,
    );
  }
}

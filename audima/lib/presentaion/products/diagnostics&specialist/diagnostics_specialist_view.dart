import 'package:flutter/material.dart';
import 'package:audima/presentaion/products/product_inside_products/product_inside_products_view.dart';
import 'package:audima/presentaion/products/products_widgets/products_widgets.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/responsive.dart';

class DiagnosticsAndSpecialistView extends StatelessWidget {
  const DiagnosticsAndSpecialistView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductInsideProductsView(
      customizedTextHeadline: CustomizedText(
          text: "Diagnostic & Specialist",
          textStyle: ResponsiveTextStyles.productHeadLineStyle(context)),
      customizedTextSecondrline: CustomizedText(
          text:
              "From contrast and glare sensitivity measurement through to refractive examination devices, we provide accuracy and reliability.",
          textStyle: ResponsiveTextStyles.productSecondrylineStyle(context)),
      productsList: diagnosticsAndSpecialist,
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:audima/presentaion/presentation_widgets.dart';
import 'package:audima/responsive.dart';

import '../../resources/assets_manager.dart';
import '../products_widgets/products_widgets.dart';

class ProductInsideProductsView extends StatefulWidget {
  final CustomizedText customizedTextHeadline;
  final CustomizedText customizedTextSecondrline;
  final List productsList;
  const ProductInsideProductsView(
      {super.key,
      required this.customizedTextHeadline,
      required this.customizedTextSecondrline,
      required this.productsList});

  @override
  State<ProductInsideProductsView> createState() =>
      _ProductInsideProductsViewState();
}

class _ProductInsideProductsViewState extends State<ProductInsideProductsView> {
  int pageIndex = 0;
  late CarouselController _carouselController;
  late ScrollController scrollController;

  @override
  void initState() {
    _carouselController = CarouselController();
    scrollController = ScrollController(initialScrollOffset: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: ScrollingWidget(
        scrollController: scrollController,
        child: ListView(
          controller: scrollController,
          children: [
            SizedBox(
              height: ResponsiveValue(context, defaultValue: 40.0, valueWhen: [
                const Condition.smallerThan(
                  name: DESKTOP,
                  value: 60.0,
                ),
                const Condition.smallerThan(name: "LARGERTABLET", value: 70.0)
              ]).value,
            ),
            widget.customizedTextHeadline,
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: widget.customizedTextSecondrline,
            ),
            SizedBox(
              height: ResponsiveValue(context, defaultValue: 25.0, valueWhen: [
                const Condition.smallerThan(
                  name: DESKTOP,
                  value: 35.0,
                ),
                const Condition.smallerThan(name: "LARGERTABLET", value: 50.0)
              ]).value,
            ),
            CarouselSlider.builder(
              itemCount: widget.productsList.length,
              carouselController: _carouselController,
              options: CarouselOptions(
                  initialPage: pageIndex,
                  onPageChanged: (index, reason) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  autoPlayInterval: const Duration(seconds: 2),
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  height: ResponsiveValues.singleProductImageHeight(context),
                  autoPlay: false),
              itemBuilder: (context, index, realIndex) {
                final productImage =
                    widget.productsList[index].inProductImageUrl;
                return ProductContainer(
                  carouselController: _carouselController,
                  productImage: productImage,
                  productName: widget.productsList[index].name,
                  productViewingData:
                      widget.productsList[index].productViewingData,
                  productPath: widget.productsList[index].pathName,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: AnimatedSmoothIndicator(
                  effect: const JumpingDotEffect(activeDotColor: Colors.black),
                  onDotClicked: (dot) {
                    _carouselController.jumpToPage(dot);
                  },
                  activeIndex: pageIndex,
                  count: widget.productsList.length),
            ),
          ],
        ),
      ),
    );
  }
}

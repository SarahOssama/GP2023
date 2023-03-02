import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:audima/presentaion/presentation_widgets.dart';
import 'package:audima/presentaion/products/product_view_widgets.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/responsive.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView>
    with TickerProviderStateMixin {
  late CarouselController _carouselController;
  late TabController tabController;
  late ScrollController scrollController;
  int pageIndex = 0;
  @override
  void initState() {
    tabController = TabController(vsync: this, length: 5);
    _carouselController = CarouselController();
    scrollController = ScrollController(initialScrollOffset: 0);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollingWidget(
      scrollController: scrollController,
      child: ListView(
        controller: scrollController,
        children: [
          const SizedBox(
            height: 100,
          ),
          ResponsiveVisibility(
            hiddenWhen: const [Condition.smallerThan(name: MOBILE)],
            child: productsTabBar(context, const Color(0xffE5E5E5),
                tabController, _carouselController),
          ),
          ResponsiveVisibility(
            hiddenWhen: const [Condition.smallerThan(name: MOBILE)],
            child: Stack(
              children: [
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: products.length,
                  options: CarouselOptions(
                    viewportFraction: 4,
                    enlargeCenterPage: false,
                    height: MediaQuery.of(context).size.height / 1.5,
                    initialPage: pageIndex,
                    autoPlay: false,
                    onPageChanged: (index, reason) {
                      pageIndex = index;
                      setState(() {
                        tabController.index = pageIndex;
                      });
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    String urlImage = products[index].inProductImageUrl;
                    return Stack(
                      children: [
                        BuildOurProdcutsImages(
                            imageUrl: urlImage,
                            imageIndex: index,
                            productPathName: products[index].pathName),
                        Positioned.fill(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomizedText(
                                text: imagesTexts[index].headLine,
                                textStyle:
                                    ResponsiveTextStyles.productHeadLineStyle(
                                        context),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: ResponsiveValues.productImageParagWidth(
                                    context),
                                child: CustomizedText(
                                  text: imagesTexts[index].parag,
                                  textStyle: ResponsiveTextStyles
                                      .productOnImageParagTextStyle(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        iconSize:
                            ResponsiveValues.leftRightAngleIconSize(context),
                        icon: Icon(
                          FontAwesomeIcons.angleLeft,
                          color: Colors.white,
                          size:
                              ResponsiveValues.leftRightAngleIconSize(context),
                        ),
                        onPressed: () {
                          _carouselController.previousPage(
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.ease);
                        },
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        iconSize:
                            ResponsiveValues.leftRightAngleIconSize(context),
                        icon: Icon(
                          FontAwesomeIcons.angleRight,
                          color: Colors.white,
                          size:
                              ResponsiveValues.leftRightAngleIconSize(context),
                        ),
                        onPressed: () {
                          _carouselController.nextPage(
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.ease);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          CustomizedText(
              text: "Browse All Products",
              textStyle: ResponsiveTextStyles.browseProductsStyle(context)),
          const SizedBox(
            height: 60,
          ),
          ResponsiveRowColumn(
            layout: ResponsiveWrapper.of(context).isSmallerThan("LARGERTABLET")
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            children: [
              for (var product in products)
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: BuildCategoriesImages(
                    imageUrl: product.toShowProducts,
                    text: product.name,
                    path: product.pathName,
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:audima/domain/model/models.dart';
import 'package:audima/presentaion/business_info/viewmodel/business_info_viewmodel.dart';

import '../../../responsive.dart';
import '../../resources/assets_manager.dart';

class BusinessInfo extends StatefulWidget {
  const BusinessInfo({Key? key}) : super(key: key);

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  late CarouselController _carouselController;
  late BusinessInfoViewModel _viewModel;
  late TextEditingController _businessInfoTextController;

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _viewModel = BusinessInfoViewModel();
    _bind();
    _carouselController = CarouselController();
    _businessInfoTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _businessInfoTextController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BusinessInfoViewObject>(
      stream: _viewModel.outputBusinessInfoViewObject,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(BusinessInfoViewObject? businessInfoViewObject) {
    if (businessInfoViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Audima',
            style: ResponsiveTextStyles.audima(context),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/businessinfo.jpg'),
                ),
              ),
            ),
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: 7,
              options: CarouselOptions(
                viewportFraction: 4,
                enlargeCenterPage: false,
                height: MediaQuery.of(context).size.height / 1.5,
                initialPage: 0,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  _viewModel
                      .addBusinessInfoDetail(_businessInfoTextController.text);
                  _viewModel.onPageChanged(index);
                },
              ),
              itemBuilder: (context, index, realIndex) {
                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.1,
                          0.5,
                          0.9,
                        ],
                        colors: [
                          Colors.black,
                          Colors.white,
                          Colors.black,
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  width: 800,
                  height: 800,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Text(
                              "${businessInfoViewObject.businessInfoObject.question}",
                              style:
                                  ResponsiveTextStyles.businessDetailTextStyle(
                                      context),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text(
                              '${businessInfoViewObject.currentIndex} / 6',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: _businessInfoTextController,
                          style:
                              ResponsiveTextStyles.businessDetailMainTextStyle(
                                  context),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle:
                                ResponsiveTextStyles.businessInfoHintStyle(
                                    context),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            hintText:
                                businessInfoViewObject.businessInfoObject.hint,
                          ),
                          autofocus: true,
                          cursorColor: Colors.white,
                          cursorHeight: 30,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 100, bottom: 100),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 100,
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {
                                _carouselController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Next",
                                  style: ResponsiveTextStyles
                                      .startYourBusinessJourney(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }
}

import 'dart:async';

import 'package:audima/app/app_prefrences.dart';
import 'package:audima/app/constants.dart';
import 'package:audima/app/di.dart';
import 'package:audima/presentaion/business_info/viewmodel/business_info_viewmodel.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:audima/domain/model/models.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../responsive.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class BusinessInfo extends StatefulWidget {
  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  final CarouselController _carouselController = CarouselController();
  final BusinessInfoViewModel _viewModel = BusinessInfoViewModel();
  final TextEditingController _companyNameTextController =
      TextEditingController();
  final TextEditingController _providedServiceTextController =
      TextEditingController();
  AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _viewModel.start();
    _companyNameTextController.addListener(() {
      _viewModel.setCompanyName(_companyNameTextController.text);
    });
    _providedServiceTextController.addListener(() {
      _viewModel
          .setCompanyServiceDescription(_providedServiceTextController.text);
    });
    _viewModel.inputMissionStatementStreamController.stream
        .listen((businessInfoWholeData) {
      //this means that the business info is completed and i should send it to the mission statement model
      if (businessInfoWholeData.isBusinessInfoCompleted) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setBusinessInfoViewed();
          Constants.BusinessInfoScreenViewStatus = true;
          context.go('/mission-statement',
              extra: businessInfoWholeData.businessInfoObject);
        });
      }
    });
  }

  late Stream mystream;
  @override
  void initState() {
    _bind();

    super.initState();
  }

  @override
  void dispose() {
    _companyNameTextController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                    ?.getScreenWidget(context, _getContentWidget(), () {}) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<dynamic>(
      stream: _viewModel.outputQuestionObject,
      initialData: _viewModel.getCurrentPage(),
      builder: (context, snapshot) {
        return _getSecondContentWidget(snapshot.data);
      },
    );
  }

  Widget _getSecondContentWidget(dynamic questionObject) {
    if (questionObject == null) {
      return Container(
        color: Colors.amber,
      );
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
              itemCount: _viewModel.getListSize(),
              options: CarouselOptions(
                onScrolled: (index) {
                  _viewModel.getNextStatusList()[_viewModel.getCurrentIndex()]
                      ? null
                      : _carouselController
                          .animateToPage(_viewModel.getCurrentIndex());
                },
                enableInfiniteScroll: false,
                viewportFraction: 4,
                enlargeCenterPage: false,
                height: MediaQuery.of(context).size.height / 1.5,
                initialPage: 0,
                autoPlay: false,
                onPageChanged: (index, reason) {
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
                  width: 900,
                  height: 900,
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
                              questionObject.question,
                              style:
                                  ResponsiveTextStyles.businessDetailTextStyle(
                                      context),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text(
                              '${_viewModel.getCurrentIndex() + 1}/${_viewModel.getListSize()}',
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
                        child: _getQuestionWidget(
                            _viewModel.getCurrentIndex(), questionObject),
                      ),
                      Spacer(),
                      _getNextButtonWidget(
                        _viewModel.getCurrentIndex(),
                      ),
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

  // _getQuestionWidget for 4 questions main widgets
  Widget _getQuestionWidget(int index, dynamic questionObject) {
    if (index == 0) {
      return _textQuestionWidget(
          questionObject.companyNameQuestionObject.hint,
          "please enter a valid company name",
          _companyNameTextController,
          _viewModel.outputIsCompanyNameValid);
    } else if (index == 1) {
      return _brandPersonalityWidget(questionObject);
    } else if (index == 2) {
      return _companyIndustryTypeWidget(questionObject);
    } else {
      return _textQuestionWidget(
          questionObject.companyServiceDescriptionQuestionObject.hint,
          "Please enter the provided service",
          _providedServiceTextController,
          _viewModel.outputIsCompanyServiceDescriptionValid);
    }
  }

  // _getNextButtonWidget for 4 questions next widgets
  Widget _getNextButtonWidget(int index) {
    if (index == 0) {
      return NextButtonWidget(
          _carouselController,
          _viewModel.outputIsNextAvailableFromCompanyNameQuestion,
          _viewModel.getCompanyNextButtonStatus(),
          "Next");
    } else if (index == 1) {
      return NextButtonWidget(
          _carouselController,
          _viewModel.outputIsNextAvailableFromBrandPersonalityQuestion,
          _viewModel.getBrandPersonalityNextButtonStatus(),
          "Next");
    } else if (index == 2) {
      return NextButtonWidget(
          _carouselController,
          _viewModel.outputIsNextAvailableFromIndustryTypeQuestion,
          _viewModel.getIndustryTypeNextButonStatus(),
          "Next");
    } else {
      return NextButtonWidget(
          _carouselController,
          _viewModel.outputIsNextAvailableFromCompanyServiceDescriptionQuestion,
          _viewModel.getCompanyServiceDescriptionNextButtonStatus(),
          "Finish");
    }
  }

  //4 widgets I will create to be shown in the carousal slider which will be handled through stream controllers in the view model
  Widget _textQuestionWidget(String hint, String error,
      TextEditingController textEditingController, Stream<bool> stream) {
    return StreamBuilder<bool>(
        stream: stream,
        builder: (context, snapshot) {
          return TextField(
            controller: textEditingController,
            style: ResponsiveTextStyles.businessDetailMainTextStyle(context),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: ResponsiveTextStyles.businessInfoHintStyle(context),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              hintText: hint,
              errorText: (snapshot.data ?? true) ? null : error,
            ),
            cursorColor: Colors.white,
            cursorHeight: 30,
          );
        });
  }

  Widget _brandPersonalityWidget(
      BrandPersonalityQuestionViewObject brandPersonalityViewObject) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _viewBrandPersonality(
              brandPersonalityViewObject.brandPersonalityList[0],
            ),
            _viewBrandPersonality(
              brandPersonalityViewObject.brandPersonalityList[1],
            ),
            _viewBrandPersonality(
              brandPersonalityViewObject.brandPersonalityList[2],
            ),
            _viewBrandPersonality(
              brandPersonalityViewObject.brandPersonalityList[3],
            ),
          ],
        ),
        SizedBox(
          height: 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _viewBrandPersonality(
              brandPersonalityViewObject.brandPersonalityList[4],
            ),
            _viewBrandPersonality(
              brandPersonalityViewObject.brandPersonalityList[5],
            ),
            _viewBrandPersonality(
              brandPersonalityViewObject.brandPersonalityList[6],
            ),
            _viewBrandPersonality(
              brandPersonalityViewObject.brandPersonalityList[7],
            ),
          ],
        ),
      ],
    );
  }

  Widget _viewBrandPersonality(
    BrandPersonalityQuestionObject brandPersonality,
  ) {
    return Expanded(
      child: AnimatedContainer(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 100),
        child: InkWell(
          onTap: () {
            _viewModel.pickBrandPersonalityType(brandPersonality);
          },
          onHover: (isHovered) {
            _viewModel.hoverOnBrandPersonalityType(brandPersonality, isHovered);
          },
          child: Column(
            children: [
              StreamBuilder<BrandPersonalityQuestionObject>(
                  stream: _viewModel.outputBrandPersonality,
                  builder: (context, snapshot) {
                    return CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: (brandPersonality.isHovered) == true ? 45 : 34,
                      child: SvgPicture.asset(
                        brandPersonality.imgUrl,
                        color: brandPersonality.color,
                        colorBlendMode: BlendMode.modulate,
                      ),
                    );
                  }),
              SizedBox(
                height: 3,
              ),
              Text(
                brandPersonality.brandpersonality,
                style: ResponsiveTextStyles.brandPersonalityTextStyle(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _companyIndustryTypeWidget(
      CompanyIndustryTypeQuestionViewObject
          companyIndustryTypeQuestionViewObject) {
    return StreamBuilder<String>(
        stream: _viewModel.outputIndustryType,
        builder: (context, snapshot) {
          return DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              hint: Text("Please select an item"),
              isExpanded: true,
              value: snapshot.data ??
                  ((_viewModel.getCompanyIndustryType() != "")
                      ? _viewModel.getCompanyIndustryType()
                      : snapshot.data),
              menuItemStyleData: MenuItemStyleData(
                  overlayColor: MaterialStatePropertyAll(Colors.grey)),
              iconStyleData: IconStyleData(iconSize: 36),
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.all(10),
                elevation: 40,
                decoration: BoxDecoration(
                  boxShadow: //make fancy box shadow
                      [BoxShadow(color: Colors.white, blurRadius: 3)],
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                  elevation: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  maxHeight: 300,
                  scrollbarTheme: ScrollbarThemeData(
                      thumbVisibility: MaterialStatePropertyAll(true),
                      thumbColor: MaterialStatePropertyAll(Colors.grey))),
              style:
                  ResponsiveTextStyles.companyIndustryTypesTextStyle(context),
              barrierColor: Colors.white.withOpacity(0.2),
              onChanged: (String? newValue) {
                _viewModel.setIndustryType(newValue);
              },
              items: companyIndustryTypeQuestionViewObject
                  .companyIndustryTypeQuestionObject
                  .map<DropdownMenuItem<String>>(
                      (CompanyIndustryTypeQuestionObject value) {
                return DropdownMenuItem<String>(
                  value: value.industrytype,
                  child: Text(
                    value.industrytype!,
                    style: ResponsiveTextStyles.companyIndustryTypesTextStyle(
                        context),
                  ),
                );
              }).toList(),
            ),
          );
        });
  }

  Widget NextButtonWidget(CarouselController _carouselController,
      Stream<bool> _stream, bool nextButtonStatus, String buttonName) {
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(right: 100, bottom: 100),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      backgroundColor: (snapshot.data ?? nextButtonStatus)
                          ? MaterialStateProperty.all(Colors.white)
                          : MaterialStateProperty.all(Colors.grey)),
                  onPressed: (snapshot.data ?? nextButtonStatus)
                      ? () {
                          _viewModel.isAllDataCollected()
                              ? _viewModel.callSendDataToMissionStatementView()
                              : _carouselController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                        }
                      : null,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      buttonName,
                      style: ResponsiveTextStyles.startYourBusinessJourney(
                          context),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

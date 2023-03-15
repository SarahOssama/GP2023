import 'dart:async';

import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/models.dart';

class BusinessInfoViewModel extends BaseViewModel
    with BusinessInfoViewModelInputs, BusinessInfoViewModelOutputs {
  final StreamController _mainStreamController =
      StreamController<dynamic>.broadcast();
  final StreamController _companyNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _isNextAvailableFromCompanyNameQuestionController =
      StreamController<void>.broadcast();
  final StreamController
      _isNextAvailableFromBrandPersonalityQuestionController =
      StreamController<void>.broadcast();
  final StreamController _brandPersonalityStreamController =
      StreamController<BrandPersonalityQuestionObject>.broadcast();
  int _currentIndex = 0;
  late final List<dynamic> _list;
  late final List<bool> _nextStatusList;
  var companyObject = CompanyNameObject("");
  var brandPersonalityObject = BrandPersonalityObject("");
  @override
  void dispose() {
    _mainStreamController.close();
    _companyNameStreamController.close();
    _isNextAvailableFromCompanyNameQuestionController.close();
    _brandPersonalityStreamController.close();
    _isNextAvailableFromBrandPersonalityQuestionController.close();
  }

  @override
  void start() {
    _list = _getBusinessInfoList();
    _nextStatusList = _getNextStatusList();
    _postDataToView();
  }

//----------------------------------------------------------main view orders
  @override
  void onPageChanged(int index) {
    if (index == 0) {
      inputIsNextAvailableFromCompanyNameQuestion.add(null);
    }
    if (index == 1) {
      inputIsNextAvailableFromBrandPersonalityQuestion.add(null);
    }
    _currentIndex = index;
    _postDataToView();
  }

  @override
  int getCurrentIndex() {
    return _currentIndex;
  }

  @override
  getCurrentPage() {
    return _list[_currentIndex];
  }

  @override
  List<bool> getNextStatusList() {
    return _nextStatusList;
  }
//-------------------------------------------------------------------------------company name view orders

  @override
  void setCompanyName(String companyName) {
    inputCompanyName.add(companyName);
    inputIsNextAvailableFromCompanyNameQuestion.add(null);
    companyObject = companyObject.copyWith(company: companyName);
    _isCompanyNameValid(companyObject.company)
        ? _nextStatusList[_currentIndex] = true
        : _nextStatusList[_currentIndex] = false;
  }

  @override
  bool getCompanyNextButtonStatus() {
    return _isCompanyNameValid(companyObject.company);
  }

  @override
  int getListSize() {
    return _list.length;
  }

  //-----------------------------------------------------------------------------brand personality view orders
  @override
  void hoverOnBrandPersonalityType(
      BrandPersonalityQuestionObject brandPersonality, bool isHovered) {
    (isHovered == false && brandPersonality.isSelected == true)
        ? isHovered = true
        : isHovered = isHovered;
    brandPersonality.isHovered = isHovered;
    //_updateBrandPersonalityList(brandPersonality);
    inputBrandPersonality.add(brandPersonality);
  }

  @override
  void pickBrandPersonalityType(
      BrandPersonalityQuestionObject brandPersonality) {
    _updateBrandPersonalityList(brandPersonality);
    inputBrandPersonality.add(brandPersonality);
    brandPersonalityObject = brandPersonalityObject.copyWith(
        brandCharacteristic: brandPersonality.brandpersonality);
    inputIsNextAvailableFromBrandPersonalityQuestion.add(null);
    _isBrandPersonalityValid(brandPersonalityObject.brandCharacteristic)
        ? _nextStatusList[_currentIndex] = true
        : _nextStatusList[_currentIndex] = false;
  }

  @override
  bool getBrandPersonalityNextButtonStatus() {
    return _isBrandPersonalityValid(brandPersonalityObject.brandCharacteristic);
  }

  //----------------------------------------------------------------------------this sink and stream will be used for all widgets in the main view
  @override
  Sink get inputQuestionObject => _mainStreamController.sink;

  @override
  Stream<dynamic> get outputQuestionObject => _mainStreamController.stream
      .map((businessInfoObject) => businessInfoObject);

  //-----------------------------------------------------------------------------this sinks and streams will be used for company name widget
  @override
  Sink get inputCompanyName => _companyNameStreamController.sink;

  @override
  Stream<bool> get outputIsCompanyNameValid =>
      _companyNameStreamController.stream
          .map((companyName) => _isCompanyNameValid(companyName));

  @override
  Sink get inputIsNextAvailableFromCompanyNameQuestion =>
      _isNextAvailableFromCompanyNameQuestionController.sink;

  @override
  Stream<bool> get outputIsNextAvailableFromCompanyNameQuestion =>
      _isNextAvailableFromCompanyNameQuestionController.stream
          .map((_) => _isCompanyNameValid(companyObject.company));

  //-----------------------------------------------------------------------------this sinks and streams will be used for brand personality widget
  @override
  Sink get inputBrandPersonality => _brandPersonalityStreamController.sink;

  @override
  Stream<BrandPersonalityQuestionObject> get outputBrandPersonality =>
      _brandPersonalityStreamController.stream
          .map((brandPersonality) => brandPersonality);
  @override
  Sink get inputIsNextAvailableFromBrandPersonalityQuestion =>
      _isNextAvailableFromBrandPersonalityQuestionController.sink;

  @override
  Stream<bool> get outputIsNextAvailableFromBrandPersonalityQuestion =>
      _isNextAvailableFromBrandPersonalityQuestionController.stream.map((_) =>
          _isBrandPersonalityValid(brandPersonalityObject.brandCharacteristic));

  //-----------------------------------------------------------------------------view model private functions and members
  //main view model private functions
  void _postDataToView() {
    inputQuestionObject.add(
      _list[_currentIndex],
    );
  }

  // company name view model private functions
  bool _isCompanyNameValid(String companyName) {
    return companyName.isNotEmpty;
  }

// personality brand view model private functions
  void _updateBrandPersonalityList(
      BrandPersonalityQuestionObject brandPersonality) {
    brandPersonality.isSelected = true;
    brandPersonality.color = Colors.white.withOpacity(1);
    for (int i = 0; i < brandsList.length; i++) {
      if (brandsList[i].index != brandPersonality.index) {
        brandsList[i].isSelected = false;
        brandsList[i].isHovered = false;
        brandsList[i].color = Colors.white.withOpacity(0.3);
      }
    }
    // brandsList[brandPersonality.index] = brandPersonality;
  }

  bool _isBrandPersonalityValid(String brandPersonality) {
    return brandPersonality != "";
  }

  //return the list of business info objects
  List<dynamic> _getBusinessInfoList() => [
        CompanyNameQuestionViewObject(
            CompanyNameQuestionObject("Company"), "What is your Company"),
        BrandPersonalityQuestionViewObject(
            brandsList, "What personality best describes your brand?"),
      ];
  //return the list of Next Status List
  List<bool> _getNextStatusList() => [false, false, false, false];
  //brands personality lists
  List<BrandPersonalityQuestionObject> brandsList = [
    BrandPersonalityQuestionObject("Creative", "assets/images/creative.svg",
        false, false, 0, Colors.white),
    BrandPersonalityQuestionObject("Authentic", "assets/images/authentic.svg",
        false, false, 1, Colors.white),
    BrandPersonalityQuestionObject("Exciting", "assets/images/exciting.svg",
        false, false, 2, Colors.white),
    BrandPersonalityQuestionObject(
        "Funny", "assets/images/funny.svg", false, false, 3, Colors.white),
    BrandPersonalityQuestionObject(
        "Rugged", "assets/images/rugged.svg", false, false, 4, Colors.white),
    BrandPersonalityQuestionObject("Sophisticated",
        "assets/images/sophisticated.svg", false, false, 5, Colors.white),
    BrandPersonalityQuestionObject("Powerful", "assets/images/powerful.svg",
        false, false, 6, Colors.white),
    BrandPersonalityQuestionObject("Thoughtful", "assets/images/thoughtful.svg",
        false, false, 7, Colors.white),
  ];
}

//inputs means the orders that our viewmodel will recieve from the view
abstract class BusinessInfoViewModelInputs {
  //orders from the the main container view which is dyamic like every single widget will call these functions
  dynamic getCurrentPage();
  void onPageChanged(int index);
  int getCurrentIndex();
  int getListSize();
  List<bool> getNextStatusList();
  //orders from company name question view
  void setCompanyName(String companyName);
  bool getCompanyNextButtonStatus();
  //orders from brand personality question view
  void hoverOnBrandPersonalityType(
      BrandPersonalityQuestionObject brandPersonality, bool isHovered);
  void pickBrandPersonalityType(
      BrandPersonalityQuestionObject brandPersonality);
  bool getBrandPersonalityNextButtonStatus();

  //stream controller input
  //this sink is for all widgets
  Sink get inputQuestionObject;
  //this sink is for company name widget
  Sink get inputCompanyName;
  Sink get inputIsNextAvailableFromCompanyNameQuestion;
  //this sink is for brand personality widget
  Sink get inputBrandPersonality;
  Sink get inputIsNextAvailableFromBrandPersonalityQuestion;
}

abstract class BusinessInfoViewModelOutputs {
  //stream controller output
  //this sink is for all widgets
  Stream<dynamic> get outputQuestionObject;
  //this sink is for company name widget
  Stream<bool> get outputIsCompanyNameValid;
  Stream<bool> get outputIsNextAvailableFromCompanyNameQuestion;
  //this sink is for brand personality widget
  Stream<BrandPersonalityQuestionObject> get outputBrandPersonality;
  Stream<bool> get outputIsNextAvailableFromBrandPersonalityQuestion;
}

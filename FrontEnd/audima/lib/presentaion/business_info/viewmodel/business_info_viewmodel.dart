import 'dart:async';

import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
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

  final StreamController _companyServiceDescriptionStreamController =
      StreamController<String>.broadcast();
  final StreamController
      _isNextAvailableFromCompanyServiceDescriptionQuestionController =
      StreamController<void>.broadcast();
  final StreamController _brandPersonalityStreamController =
      StreamController<BrandPersonalityQuestionObject>.broadcast();
  final StreamController
      _isNextAvailableFromBrandPersonalityQuestionController =
      StreamController<void>.broadcast();
  final StreamController _industryTypeStreamController =
      StreamController<String>.broadcast();
  final StreamController _isNextAvailableFromIndustryTypeQuestionController =
      StreamController<void>.broadcast();

  //stream controller to invoke mission statement widget
  final StreamController<BusinessWholeData>
      inputMissionStatementStreamController =
      StreamController<BusinessWholeData>.broadcast();

  int _currentIndex = 0;
  late final List<dynamic> _list;
  late final List<bool> _nextStatusList;
  var _businessInfoObject = BusinessInfoObject("", "", "", "");

  @override
  void dispose() {
    _mainStreamController.close();
    _companyNameStreamController.close();
    _isNextAvailableFromCompanyNameQuestionController.close();
    _brandPersonalityStreamController.close();
    _isNextAvailableFromBrandPersonalityQuestionController.close();
    _industryTypeStreamController.close();
    _isNextAvailableFromIndustryTypeQuestionController.close();
    _companyServiceDescriptionStreamController.close();
    _isNextAvailableFromCompanyServiceDescriptionQuestionController.close();
    inputMissionStatementStreamController.close();
    super.dispose();
  }

  @override
  void start() {
    inputState.add(ContentState());
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
    if (index == 2) {
      inputIsNextAvailableFromIndustryTypeQuestion.add(null);
    }
    if (index == 3) {
      inputIsNextAvailableFromCompanyServiceDescriptionQuestion.add(null);
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

  @override
  bool isAllDataCollected() {
    return _currentIndex == _list.length - 1 ? true : false;
  }

  @override
  void callSendDataToMissionStatementView() {
    inputMissionStatementStreamController.sink
        .add(BusinessWholeData(_businessInfoObject, true));
    // inputState.add(ContentState());
  }
//-------------------------------------------------------------------------------company name view orders

  @override
  void setCompanyName(String companyName) {
    inputCompanyName.add(companyName);
    inputIsNextAvailableFromCompanyNameQuestion.add(null);
    _businessInfoObject =
        _businessInfoObject.copyWith(companyName: companyName);
    _isCompanyNameValid(_businessInfoObject.companyName)
        ? _nextStatusList[_currentIndex] = true
        : _nextStatusList[_currentIndex] = false;
  }

  @override
  bool getCompanyNextButtonStatus() {
    return _isCompanyNameValid(_businessInfoObject.companyName);
  }

  @override
  int getListSize() {
    return _list.length;
  }
// ------------------------------------------------------------------------------Service Description view orders

  @override
  void setCompanyServiceDescription(String companyServiceDescription) {
    inputCompanyServiceDescription.add(companyServiceDescription);
    inputIsNextAvailableFromCompanyServiceDescriptionQuestion.add(null);
    _businessInfoObject = _businessInfoObject.copyWith(
        serviceProvided: companyServiceDescription);
    _isServiceDescriptionValid(_businessInfoObject.serviceProvided)
        ? _nextStatusList[_currentIndex] = true
        : _nextStatusList[_currentIndex] = false;
  }

  @override
  bool getCompanyServiceDescriptionNextButtonStatus() {
    return _isServiceDescriptionValid(_businessInfoObject.serviceProvided);
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
    _businessInfoObject = _businessInfoObject.copyWith(
        brandPersonality: brandPersonality.brandpersonality);
    inputIsNextAvailableFromBrandPersonalityQuestion.add(null);
    _isBrandPersonalityValid(_businessInfoObject.brandPersonality)
        ? _nextStatusList[_currentIndex] = true
        : _nextStatusList[_currentIndex] = false;
  }

  @override
  bool getBrandPersonalityNextButtonStatus() {
    return _isBrandPersonalityValid(_businessInfoObject.brandPersonality);
  }
  //-----------------------------------------------------------------------------company intdustry types view orders

  @override
  void setIndustryType(String? industryType) {
    inputIndustryType.add(industryType);
    _businessInfoObject =
        _businessInfoObject.copyWith(industryType: industryType!);
    inputIsNextAvailableFromIndustryTypeQuestion.add(null);
    _isIndustryTypeValid(_businessInfoObject.industryType)
        ? _nextStatusList[_currentIndex] = true
        : _nextStatusList[_currentIndex] = false;
  }

  @override
  String getCompanyIndustryType() {
    return _businessInfoObject.industryType;
  }

  @override
  bool getIndustryTypeNextButonStatus() {
    return _isIndustryTypeValid(_businessInfoObject.industryType);
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
  Sink get inputIsNextAvailableFromCompanyNameQuestion =>
      _isNextAvailableFromCompanyNameQuestionController.sink;
  @override
  Stream<bool> get outputIsCompanyNameValid =>
      _companyNameStreamController.stream
          .map((companyName) => _isCompanyNameValid(companyName));
  @override
  Stream<bool> get outputIsNextAvailableFromCompanyNameQuestion =>
      _isNextAvailableFromCompanyNameQuestionController.stream
          .map((_) => _isCompanyNameValid(_businessInfoObject.companyName));

//--------------------------------------------------------------------------------this sinks and streams will be used for provided service description widget

  @override
  Sink get inputCompanyServiceDescription =>
      _companyServiceDescriptionStreamController.sink;

  @override
  Sink get inputIsNextAvailableFromCompanyServiceDescriptionQuestion =>
      _isNextAvailableFromCompanyServiceDescriptionQuestionController.sink;

  @override
  Stream<bool> get outputIsCompanyServiceDescriptionValid =>
      _companyServiceDescriptionStreamController.stream.map(
          (serviceDescription) =>
              _isServiceDescriptionValid(serviceDescription));

  @override
  Stream<bool> get outputIsNextAvailableFromCompanyServiceDescriptionQuestion =>
      _isNextAvailableFromCompanyServiceDescriptionQuestionController.stream
          .map((_) =>
              _isServiceDescriptionValid(_businessInfoObject.serviceProvided));

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
          _isBrandPersonalityValid(_businessInfoObject.brandPersonality));

  //-----------------------------------------------------------------------------this sinks and streams will be used for company industry types widget

  @override
  Sink get inputIndustryType => _industryTypeStreamController.sink;

  @override
  Stream<String> get outputIndustryType =>
      _industryTypeStreamController.stream.map((item) => item);

  @override
  Sink get inputIsNextAvailableFromIndustryTypeQuestion =>
      _isNextAvailableFromIndustryTypeQuestionController.sink;

  @override
  Stream<bool> get outputIsNextAvailableFromIndustryTypeQuestion =>
      _isNextAvailableFromIndustryTypeQuestionController.stream
          .map((_) => _isIndustryTypeValid(_businessInfoObject.industryType));

  //-----------------------------------------------------------------------------view model private functions and members
  //main view model private functions
  void _postDataToView() {
    inputQuestionObject.add(
      _list[_currentIndex],
    );
    //if the view to be posted is for industry type question i would check if the companIndustryType object has a value to add it to the snapshot of its stream builder
  }

  // ----------------------------------------------------------------------------company name view model private functions
  bool _isCompanyNameValid(String companyName) {
    return companyName.isNotEmpty;
  }

  // ----------------------------------------------------------------------------service description view model private functions
  bool _isServiceDescriptionValid(String serviceDescription) {
    return serviceDescription.isNotEmpty;
  }

// ------------------------------------------------------------------------------personality brand view model private functions
  void _updateBrandPersonalityList(
      BrandPersonalityQuestionObject brandPersonality) {
    brandPersonality.isSelected = true;
    brandPersonality.color = Colors.white.withOpacity(1);
    for (int i = 0; i < _brandsList.length; i++) {
      if (_brandsList[i].index != brandPersonality.index) {
        _brandsList[i].isSelected = false;
        _brandsList[i].isHovered = false;
        _brandsList[i].color = Colors.white.withOpacity(0.3);
      }
    }
  }

  bool _isBrandPersonalityValid(String brandPersonality) {
    return brandPersonality != "";
  }

  //-----------------------------------------------------------------------------company industry types view model private functions
  bool _isIndustryTypeValid(String industryType) {
    return industryType.isNotEmpty;
  }

  //------------------------------------------------------------------------------main view model private members
  //return the list of business info objects
  List<dynamic> _getBusinessInfoList() => [
        CompanyNameQuestionViewObject(
            CompanyNameQuestionObject("Company"), "What is your Company Name?"),
        BrandPersonalityQuestionViewObject(
            _brandsList, "What personality best describes your brand?"),
        CompanyIndustryTypeQuestionViewObject(
            _industryTypesList, "What industry is your company in?"),
        CompanyServiceDescriptionQuestionViewObject(
            CompanyServiceDescriptionQuestionObject("description"),
            "In few words, what's the main\ngood or service you provide?"),
      ];

  //-----------------------------------------------------------------------------brand personality list of items
  List<BrandPersonalityQuestionObject> _brandsList = [
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
  //----------------------------------------------------------------------------industry type private members
  List<CompanyIndustryTypeQuestionObject> _industryTypesList = [
    CompanyIndustryTypeQuestionObject("Advertising"),
    CompanyIndustryTypeQuestionObject("Agriculture"),
    CompanyIndustryTypeQuestionObject("Automotive"),
    CompanyIndustryTypeQuestionObject("Banking"),
    CompanyIndustryTypeQuestionObject("Beauty"),
    CompanyIndustryTypeQuestionObject("Business"),
    CompanyIndustryTypeQuestionObject("Construction"),
    CompanyIndustryTypeQuestionObject("Consulting"),
    CompanyIndustryTypeQuestionObject("Education"),
    CompanyIndustryTypeQuestionObject("Energy"),
    CompanyIndustryTypeQuestionObject("Entertainment"),
    CompanyIndustryTypeQuestionObject("Fashion"),
    CompanyIndustryTypeQuestionObject("Finance"),
    CompanyIndustryTypeQuestionObject("Food"),
    CompanyIndustryTypeQuestionObject("Health"),
    CompanyIndustryTypeQuestionObject("Hospitality"),
    CompanyIndustryTypeQuestionObject("Insurance"),
    CompanyIndustryTypeQuestionObject("Legal"),
    CompanyIndustryTypeQuestionObject("Manufacturing"),
    CompanyIndustryTypeQuestionObject("Marketing"),
    CompanyIndustryTypeQuestionObject("Media"),
    CompanyIndustryTypeQuestionObject("Medical"),
    CompanyIndustryTypeQuestionObject("Nonprofit"),
    CompanyIndustryTypeQuestionObject("Real Estate"),
    CompanyIndustryTypeQuestionObject("Retail"),
    CompanyIndustryTypeQuestionObject("Sports"),
    CompanyIndustryTypeQuestionObject("Technology"),
    CompanyIndustryTypeQuestionObject("Telecommunications"),
    CompanyIndustryTypeQuestionObject("Transportation"),
    CompanyIndustryTypeQuestionObject("Travel"),
    CompanyIndustryTypeQuestionObject("Other"),
  ];

  //return the list of Next Status List
  List<bool> _getNextStatusList() => [false, false, false, false];
}

//inputs means the orders that our viewmodel will recieve from the view
abstract class BusinessInfoViewModelInputs {
  //orders from the the main container view which is dyamic like every single widget will call these functions
  dynamic getCurrentPage();
  void onPageChanged(int index);
  int getCurrentIndex();
  int getListSize();
  List<bool> getNextStatusList();
  bool isAllDataCollected();
  void callSendDataToMissionStatementView();
  //orders from company name question view
  void setCompanyName(String companyName);
  bool getCompanyNextButtonStatus();
  //orders from company service provided
  void setCompanyServiceDescription(String companyServiceDescription);
  bool getCompanyServiceDescriptionNextButtonStatus();
  //orders from brand personality question view
  void hoverOnBrandPersonalityType(
      BrandPersonalityQuestionObject brandPersonality, bool isHovered);
  void pickBrandPersonalityType(
      BrandPersonalityQuestionObject brandPersonality);
  bool getBrandPersonalityNextButtonStatus();
  //orders from industry type question view
  void setIndustryType(String? industryType);
  bool getIndustryTypeNextButonStatus();
  String getCompanyIndustryType();
  //stream controller input
  //this sink is for all widgets
  Sink get inputQuestionObject;
  //this sink is for company name widget
  Sink get inputCompanyName;
  Sink get inputIsNextAvailableFromCompanyNameQuestion;
  //this sink is for company service description widget
  Sink get inputCompanyServiceDescription;
  Sink get inputIsNextAvailableFromCompanyServiceDescriptionQuestion;
  //this sink is for brand personality widget
  Sink get inputBrandPersonality;
  Sink get inputIsNextAvailableFromBrandPersonalityQuestion;
  //this sink is for industry type widget
  Sink get inputIndustryType;
  Sink get inputIsNextAvailableFromIndustryTypeQuestion;
}

abstract class BusinessInfoViewModelOutputs {
  //stream controller output
  //this sink is for all widgets
  Stream<dynamic> get outputQuestionObject;
  //this sink is for company name widget
  Stream<bool> get outputIsCompanyNameValid;
  Stream<bool> get outputIsNextAvailableFromCompanyNameQuestion;
  //this sink is for company service description widget
  Stream<bool> get outputIsCompanyServiceDescriptionValid;
  Stream<bool> get outputIsNextAvailableFromCompanyServiceDescriptionQuestion;

  //this sink is for brand personality widget
  Stream<BrandPersonalityQuestionObject> get outputBrandPersonality;
  Stream<bool> get outputIsNextAvailableFromBrandPersonalityQuestion;
  //this sink is for industry type widget
  Stream<String> get outputIndustryType;
  Stream<bool> get outputIsNextAvailableFromIndustryTypeQuestion;
}

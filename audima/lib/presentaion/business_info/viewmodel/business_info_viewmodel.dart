import 'dart:async';

import 'package:audima/domain/model/models.dart';

import '../../base/baseviewmodel.dart';

class BusinessInfoViewModel extends BaseViewModel
    with BusinessinfoViewModelInputs, BusinessinfoViewModelOutputs {
  // stream controllers outputs
  final StreamController _streamController =
      StreamController<BusinessInfoViewObject>();
  int _currentIndex = 0;
  late final List<BusinessInfoObject> _list;

  //business info view model inputs---------------------------------------------
  @override
  void dispose() {
    _streamController.close();
    // TODO: implement dispose
  }

  @override
  void start() {
    //viewmodel start your job
    _list = _getBusinessInfoObject();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
    // TODO: implement goNext
  }

  @override
  void addBusinessInfoDetail(String businessInfoText) {
    _list[_currentIndex].answer = businessInfoText;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputBusinessInfoViewObject => _streamController.sink;
  //----------------------------------------------------------------------------
  //buisness info viewmodel outputs
  @override
  Stream<BusinessInfoViewObject> get outputBusinessInfoViewObject =>
      _streamController.stream
          .map((BusinessInfoViewObject) => BusinessInfoViewObject);
  //----------------------------------------------------------------------------

  //BusinessInfo private functions

  void _postDataToView() {
    inputBusinessInfoViewObject.add(BusinessInfoViewObject(
        _list[_currentIndex], _list.length, _currentIndex));
  }

  //return the list of business info objects
  List<BusinessInfoObject> _getBusinessInfoObject() => [
        BusinessInfoObject("what is your company", "company", ""),
        BusinessInfoObject("what is your profession", "profession", ""),
        BusinessInfoObject(
            "can you specifiy your business need", "profession", ""),
        BusinessInfoObject(
            "what do you categorize your business as", "profession", ""),
        BusinessInfoObject("test1", "profession", ""),
        BusinessInfoObject("test2", "profession", ""),
        BusinessInfoObject("test3", "profession", ""),
      ];
}

//inputs means the orders that our viewmodel will recieve from the view
abstract class BusinessinfoViewModelInputs {
  void goNext(); //when user click next button
  void addBusinessInfoDetail(String businessInfoText);
  void onPageChanged(int index);

  //stream controller input
  Sink get inputBusinessInfoViewObject;
}

abstract class BusinessinfoViewModelOutputs {
  //stream controller output
  Stream<BusinessInfoViewObject> get outputBusinessInfoViewObject;
}

import 'dart:async';

import 'package:audima/domain/usecase/businessInfo_usecase.dart';
import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';

class MissionStatementViewModel extends BaseViewModel
    with MissionStatementViewModelInputs, MissionStatementViewModelOutputs {
  final MissionStatementUseCase _missionStatementUseCase;
  MissionStatementViewModel(this._missionStatementUseCase);
  final StreamController _missionStatementStreamController =
      StreamController<String>.broadcast();
  final StreamController _editSaveButtonNameStreamController =
      StreamController<EditOrSaveButtonData>.broadcast();
  final StreamController _isEditingEnabledStreamController =
      StreamController<List<bool>>.broadcast();
  var missionStatementObject = MissionStatementObject("");

  // ---------------------------------------------------------------------------initialization phase
  late String missionStatementBasicStatement;
  String editOrSave = "Edit";
  String regenMissionStatement = "Re-Generate";

  @override
  void setMissionBasicStatement(BusinessInfoObject businessInfoObject) {
    missionStatementBasicStatement =
        "our company Name is ${businessInfoObject.companyName},our brand personality is ${businessInfoObject.brandPersonality}, we are in the ${businessInfoObject.industryType} and we provide ${businessInfoObject.serviceProvided} ";
  }

  @override
  void dispose() {
    super.dispose();
    _missionStatementStreamController.close();
    _editSaveButtonNameStreamController.close();
    _isEditingEnabledStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
    _generateMissionStatement();
  }

  @override
  void doEditOrSaveFunction() {
    if (editOrSave == "Edit") {
      editOrSave = "Save";
      inputIsEditingEnabled.add([true, _checkIfMissionStatementIsEmpty()]);
      inputEditSaveButtonName.add(
          EditOrSaveButtonData(editOrSave, _checkIfMissionStatementIsEmpty()));
    } else {
      editOrSave = "Edit";
      inputIsEditingEnabled.add([false, _checkIfMissionStatementIsEmpty()]);
      inputEditSaveButtonName.add(
          EditOrSaveButtonData(editOrSave, _checkIfMissionStatementIsEmpty()));
    }
  }

  @override
  void reGenerateMissionStatement() {
    //put everything to default state
    editOrSave = "Edit";
    inputEditSaveButtonName.add(EditOrSaveButtonData(editOrSave, false));
    inputIsEditingEnabled.add([false, false]);
    _generateMissionStatement();
  }

  @override
  void editMissionStatement(String editedMissionStatement) {
//if i started editing mission statement which was already empty so enable save button and delete error hint
    if (editedMissionStatement != "" && _checkIfMissionStatementIsEmpty()) {
      inputIsEditingEnabled.add([editOrSave == "Save" ? true : false, false]);
      inputEditSaveButtonName.add(
          EditOrSaveButtonData(editOrSave, !_checkIfMissionStatementIsEmpty()));
    }
    missionStatementObject = missionStatementObject.copyWith(
        missionStatement: editedMissionStatement);
    //if i removed all mission statement generated so disable save button and show error hint
    if (missionStatementObject.missionStatement == "") {
      inputIsEditingEnabled.add([editOrSave == "Save" ? true : false, true]);
      inputEditSaveButtonName.add(
          EditOrSaveButtonData(editOrSave, _checkIfMissionStatementIsEmpty()));
    }
  }

  //------------------------------------------------------------------------------helper functions
  void _generateMissionStatement() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popUpLoadingState,
        message: "Generating Business Statement"));

    (await _missionStatementUseCase.execute(
            MissionStatementUseCaseInput(missionStatementBasicStatement)))
        .fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popUpErrorState, failure.message));

      //left means failure
    }, (data) {
      //right means success
      inputMissionStatement.add(data.missionStatement);
      missionStatementObject = missionStatementObject.copyWith(
          missionStatement: data.missionStatement);
      inputState.add(ContentState());
    });
  }

  bool _checkIfMissionStatementIsEmpty() {
    if (missionStatementObject.missionStatement == "") {
      return true;
    } else {
      return false;
    }
  }

  //----------------------------------------------------------------------------main sink and streams
  @override
  Sink get inputMissionStatement => _missionStatementStreamController.sink;

  @override
  Stream<String> get outputMissionStatement =>
      _missionStatementStreamController.stream
          .map((missionStatement) => missionStatement);
  @override
  Sink get inputEditSaveButtonName => _editSaveButtonNameStreamController.sink;

  @override
  Stream<EditOrSaveButtonData> get outputEditSaveButtonName =>
      _editSaveButtonNameStreamController.stream
          .map((editSaveButtonName) => editSaveButtonName);

  @override
  Sink get inputIsEditingEnabled => _isEditingEnabledStreamController.sink;

  @override
  Stream<List<bool>> get outputIsEditingEnabled =>
      _isEditingEnabledStreamController.stream.map((edit) => edit);
}

//------------------------------------------------------------------------------inputs and orders
abstract class MissionStatementViewModelInputs {
  //orders
  void setMissionBasicStatement(BusinessInfoObject businessInfoObject);
  void reGenerateMissionStatement();
  void doEditOrSaveFunction();
  void editMissionStatement(String editedMissionStatement);
  //stream controllers inputs
  Sink get inputMissionStatement;
  Sink get inputEditSaveButtonName;
  Sink get inputIsEditingEnabled;
}

//------------------------------------------------------------------------------outputs
abstract class MissionStatementViewModelOutputs {
  Stream<String> get outputMissionStatement;
  Stream<EditOrSaveButtonData> get outputEditSaveButtonName;
  Stream<List<bool>> get outputIsEditingEnabled;
}

//------------------------------------------------------------------------------useful objects
class EditOrSaveButtonData {
  String editOrSaveButtonName;
  bool isMissionStatementEmpty;
  EditOrSaveButtonData(this.editOrSaveButtonName, this.isMissionStatementEmpty);
}

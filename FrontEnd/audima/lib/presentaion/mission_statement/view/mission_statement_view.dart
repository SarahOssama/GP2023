import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:audima/app/app_prefrences.dart';
import 'package:audima/app/constants.dart';
import 'package:audima/app/di.dart';
import 'package:audima/presentaion/base/baseview.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:audima/presentaion/mission_statement/viewmodel/mission_statement_viewmodel.dart';
import 'package:audima/presentaion/resources/routes_manager.dart';
import 'package:audima/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MissionStatementView extends StatefulWidget {
  BusinessInfoObject businessInfoObject;
  MissionStatementView({required this.businessInfoObject});
  @override
  State<MissionStatementView> createState() => _MissionStatementViewState();
}

//view model and mission statement text controller
late MissionStatementViewModel _viewModel;
//app prefereneces for saving mission statement
late AppPreferences _appPreferences;

late TextEditingController _missionStatementTextController;
//variable which only will generate mission statement once
bool _isStarted = false;

late ScrollController textScrollController;

class _MissionStatementViewState extends State<MissionStatementView> {
  @override
  void initState() {
    print("mission statement view init");
    _appPreferences = instance<AppPreferences>();
    _viewModel = instance<MissionStatementViewModel>();
    _missionStatementTextController = TextEditingController();
    textScrollController = ScrollController();
    _viewModel.outputMissionStatement.listen((missionStatement) {
      _missionStatementTextController.text = missionStatement;
    });
    _missionStatementTextController.addListener(() {
      _viewModel.editMissionStatement(_missionStatementTextController.text);
    });
    _viewModel.setMissionBasicStatement(widget.businessInfoObject);
    super.initState();
  }

  @override
  void dispose() {
    print("mission statement view disposed");

    _missionStatementTextController.removeListener(() {});
    _missionStatementTextController.clear();
    _missionStatementTextController.dispose();
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
            snapshot.data == null ? _viewModel.start() : null;
            if (snapshot.connectionState == ConnectionState.active) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {}) ??
                  _getContentWidget();
            } else {
              return _getContentWidget();
            }
          }),
    );
  }

  Widget _getContentWidget() {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MainScaffold(
        previousRoute: Routes.businessInfo,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: BlackedShadowContainer(
            width: 300,
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Mission Statement',
                  style: ResponsiveTextStyles.audima(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: StreamBuilder<List<bool>>(
                    stream: _viewModel.outputIsEditingEnabled,
                    builder: (context, snapshot) {
                      return Scrollbar(
                        thumbVisibility: true,
                        controller: textScrollController,
                        child: TextField(
                          scrollController: textScrollController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.multiline,
                          minLines: 1, //Normal textInputField will be displayed
                          maxLines: 6, // wh

                          controller: _missionStatementTextController,
                          style: ResponsiveTextStyles.missionStatementTextStyle(
                              context),
                          decoration: InputDecoration(
                            enabledBorder: (snapshot.data?[0] ?? false)
                                ? const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  )
                                : null,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle:
                                ResponsiveTextStyles.businessInfoHintStyle(
                                    context),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            errorText: (snapshot.data?[1] ?? false)
                                ? "please re_generate or edit your mission statement"
                                : null,
                          ),
                          cursorColor: Colors.white,
                          cursorHeight: 30,
                          showCursor:
                              (snapshot.data?[0] ?? false) ? true : false,
                          readOnly: (snapshot.data?[0] ?? false) ? false : true,
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StreamBuilder<EditOrSaveButtonData>(
                      stream: _viewModel.outputEditSaveButtonName,
                      builder: (context, snapshot) {
                        return ReactiveElevatedButton(
                          text: _viewModel.editOrSave,
                          onPressed: () => _viewModel.doEditOrSaveFunction(),
                          buttonColorCondition:
                              (snapshot.data?.isMissionStatementEmpty ?? false),
                          buttonPressedCondition: (snapshot
                                      .data?.isMissionStatementEmpty ??
                                  false) &&
                              (snapshot.data?.editOrSaveButtonName == "Save"),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ReactiveElevatedButton(
                        text: _viewModel.regenMissionStatement,
                        onPressed: () =>
                            _viewModel.reGenerateMissionStatement(),
                        buttonColorCondition: false,
                        buttonPressedCondition: false),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReactiveElevatedButton(
                        text: "Proceed with Video",
                        onPressed: () {
                          //before proceeding to video we need to save the mission statement to the app preferences so that we can use it in the ending screen
                          _appPreferences.setMissionStatement(
                              _missionStatementTextController.text);

                          Navigator.of(context).pushNamed(Routes.businessVideo);
                        },
                        buttonColorCondition: false,
                        buttonPressedCondition: false),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

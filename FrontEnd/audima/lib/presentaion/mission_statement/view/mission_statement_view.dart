import 'dart:async';

import 'package:audima/app/constants.dart';
import 'package:audima/app/di.dart';
import 'package:audima/presentaion/base/baseview.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:audima/presentaion/mission_statement/viewmodel/mission_statement_viewmodel.dart';
import 'package:audima/responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MissionStatementView extends StatefulWidget {
  BusinessInfoObject businessInfoObject;
  MissionStatementView({required this.businessInfoObject});
  @override
  State<MissionStatementView> createState() => _MissionStatementViewState();
}

final MissionStatementViewModel _viewModel =
    instance<MissionStatementViewModel>();
final TextEditingController _missionStatementTextController =
    TextEditingController();
final StreamController<FlowState> _missionStatementStreamController =
    StreamController<FlowState>.broadcast();

class _MissionStatementViewState extends State<MissionStatementView> {
  @override
  void initState() {
    //make missionStatementStreamController listen to _viewmodel.outputState
    Constants.BusinessInfoScreenViewStatus = false;
    _viewModel.outputMissionStatement.listen((missionStatement) {
      _missionStatementTextController.text = missionStatement;
    });
    _missionStatementTextController.addListener(() {
      _viewModel.editMissionStatement(_missionStatementTextController.text);
    });
    _missionStatementStreamController.addStream(_viewModel.outputState);
    _viewModel.setMissionBasicStatement(widget.businessInfoObject);
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _missionStatementStreamController.close();
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
            print("mission");
            return snapshot.data?.getScreenWidget(
                    context,
                    ReactiveElevatedButton(
                        text: "Proceed with Video",
                        onPressed: () {
                          context.go("/business-video");
                        },
                        buttonColorCondition: false,
                        buttonPressedCondition: false),
                    () {}) ??
                ReactiveElevatedButton(
                    text: "Proceed with Video",
                    onPressed: () {
                      context.go("/business-video");
                    },
                    buttonColorCondition: false,
                    buttonPressedCondition: false);
          }),
    );
  }

  Widget _getContentWidget() {
    return MainScaffold(
        child: BlackedShadowContainer(
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
                        return TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.multiline,
                          minLines: 1, //Normal textInputField will be displayed
                          maxLines: 6, // wh

                          controller: _missionStatementTextController,
                          style: ResponsiveTextStyles.MissionStatementTextStyle(
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
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StreamBuilder<EditOrSaveButtonData>(
                        stream: _viewModel.outputEditSaveButtonName,
                        builder: (context, snapshot) {
                          return ReactiveElevatedButton(
                              text: _viewModel.editOrSave,
                              onPressed: () =>
                                  _viewModel.doEditOrSaveFunction(),
                              buttonColorCondition:
                                  (snapshot.data?.isMissionStatementEmpty ??
                                      false),
                              buttonPressedCondition:
                                  (snapshot.data?.isMissionStatementEmpty ??
                                          false) &&
                                      (snapshot.data?.editOrSaveButtonName ==
                                          "Save"));
                        }),
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
                          context.push("/business-video");
                        },
                        buttonColorCondition: false,
                        buttonPressedCondition: false),
                  ],
                ),
              ],
            ),
            width: 300,
            height: 500));
  }
}

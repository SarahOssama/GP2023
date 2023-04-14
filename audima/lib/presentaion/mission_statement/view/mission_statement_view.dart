import 'dart:async';

import 'package:audima/app/constants.dart';
import 'package:audima/app/di.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:audima/presentaion/mission_statement/viewmodel/mission_statement_viewmodel.dart';
import 'package:audima/responsive.dart';
import 'package:flutter/material.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<FlowState>(
          stream: _missionStatementStreamController.stream,
          builder: (context, snapshot) {
            return snapshot.data
                    ?.getScreenWidget(context, _getContentWidget(), () {}) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/mission-statement.jpg'),
              ),
            ),
          ),
          Container(
            width: 600,
            height: 600,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black, //New
                    blurRadius: 25.0,
                    offset: Offset(0, -10)),
                BoxShadow(
                    color: Colors.black, //New
                    blurRadius: 25.0,
                    offset: Offset(0, 25))
              ],
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
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
                    _getElevatedButton(_viewModel.editOrSave,
                        () => _viewModel.doEditOrSaveFunction(), true),
                    const SizedBox(
                      width: 20,
                    ),
                    _getElevatedButton(_viewModel.regenMissionStatement,
                        () => _viewModel.reGenerateMissionStatement(), false),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //create elevated button widget that takes a string and a funtion for me
  Widget _getElevatedButton(
      String text, Function() onPressed, bool doStreamBuilder) {
    return doStreamBuilder
        ? StreamBuilder<EditOrSaveButtonData>(
            stream: _viewModel.outputEditSaveButtonName,
            builder: (context, snapshot) {
              return Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.white, //New
                        blurRadius: 3,
                        offset: Offset(0, -3)),
                    BoxShadow(
                        color: Colors.white, //New
                        blurRadius: 3,
                        offset: Offset(0, 3))
                  ],
                  color: (snapshot.data?.isMissionStatementEmpty ?? false)
                      ? Colors.grey
                      : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                ),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        backgroundColor:
                            (snapshot.data?.isMissionStatementEmpty ?? false)
                                ? MaterialStateProperty.all(Colors.grey)
                                : MaterialStateProperty.all(Colors.white)),
                    onPressed:
                        (snapshot.data?.isMissionStatementEmpty ?? false) &&
                                (snapshot.data?.editOrSaveButtonName == "Save")
                            ? null
                            : onPressed,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        snapshot.data?.editOrSaveButtonName ?? text,
                        style: ResponsiveTextStyles.startYourBusinessJourney(
                            context),
                      ),
                    )),
              );
            })
        : Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.white, //New
                    blurRadius: 3,
                    offset: Offset(0, -3)),
                BoxShadow(
                    color: Colors.white, //New
                    blurRadius: 3,
                    offset: Offset(0, 3))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: onPressed,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: ResponsiveTextStyles.startYourBusinessJourney(context),
                ),
              ),
            ),
          );
  }
}

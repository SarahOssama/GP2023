import 'dart:io';
import 'package:audima/app/di.dart';
import 'package:audima/presentaion/base/baseview.dart';
import 'package:audima/presentaion/business_info/viewModel/business_info_viewModel.dart';
import 'package:audima/presentaion/business_video/viewModel/business_video_viewModel.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:video_player/video_player.dart';

class BusinessVideo extends StatefulWidget {
  @override
  _BusinessVideoState createState() => _BusinessVideoState();
}
  final BusinessVideoViewModel _viewModel =
     BusinessVideoViewModel(instance(), instance());
class _BusinessVideoState extends State<BusinessVideo> {
  // late VideoPlayerController _controller;
  final TextEditingController _videoEditsTextController =
      TextEditingController();

  @override
  void initState() {
    
    _videoEditsTextController.addListener(() {
      _viewModel.updateVideoEdits(_videoEditsTextController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data
                  ?.getScreenWidget(context, _getContentWidget(), () {}) ??
              _getContentWidget();
        });
  }

  Widget _getContentWidget() {
    return ContainerWithinImage(
      mainChild: StreamBuilder<bool>(
          stream: _viewModel.outputIsVideoPlayerControllerInitialized,
          builder: (context, snapshot) {
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              child: snapshot.data == true
                  ? Stack(
                      children: [
                        VideoPlayer(
                          _viewModel.controller,
                        ),
                        Positioned.fill(
                            child: Stack(children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: VideoProgressIndicator(
                              _viewModel.controller,
                              allowScrubbing: true,
                            ),
                          )
                        ])),
                      ],
                    )
                  : SizedBox.shrink(),
            );
          }),
      secondaryChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsAnyVideoUploaded,
                      builder: (context, snapshot) {
                        return ReactiveElevatedButton(
                          text: snapshot.data == true
                              ? 'Choose another Video'
                              : "Choose your video",
                          onPressed: () async {
                            await _viewModel.pickVideo();
                          },
                          buttonColorCondition: false,
                          buttonPressedCondition: false,
                        );
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          StreamBuilder<bool>(
              stream: _viewModel.outputIsAnyVideoUploaded,
              builder: (context, snapshot) {
                return snapshot.data == true
                    ? Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextField(
                                textInputAction: TextInputAction.done,
                                showCursor: true,
                                controller: _videoEditsTextController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Type in your video edits',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: StreamBuilder<bool>(
                                stream: _viewModel.outputVideoEditsState,
                                builder: (context, snapshot) {
                                  return ReactiveElevatedButton(
                                    text: 'Edit',
                                    onPressed: () {
                                      _viewModel.editVideo(_videoEditsTextController);
                                    },
                                    buttonColorCondition:
                                        (snapshot.data??false)
                                            ? false
                                            : true,
                                    buttonPressedCondition:
                                        (snapshot.data??false)
                                            ? false
                                            : true,
                                  );
                                }
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink();
              })
        ],
      ),
      containerContentHeight: 300,
      containerContentWidth: MediaQuery.of(context).size.width / 1.2,
    );
  }
}

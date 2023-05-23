import 'package:audima/app/di.dart';
import 'package:audima/presentaion/base/baseview.dart';
import 'package:audima/presentaion/business_video/viewModel/business_video_viewModel.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BusinessVideo extends StatefulWidget {
  @override
  _BusinessVideoState createState() => _BusinessVideoState();
}

final BusinessVideoViewModel _viewModel = BusinessVideoViewModel(
    instance(), instance(), instance(), instance(), instance());

class _BusinessVideoState extends State<BusinessVideo> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  final TextEditingController _videoEditsTextController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    _videoEditsTextController.addListener(() {
      _viewModel.updateVideoEdits(_videoEditsTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return snapshot.data
                    ?.getScreenWidget(context, _getContentWidget(), () {}) ??
                _getContentWidget();
          } else {
            return _getContentWidget();
          }
        });
  }

  Widget _getContentWidget() {
    return MainScaffold(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 4),
              scrollDirection: Axis.horizontal,
              children: [
                //the main video which will be uploaded first by the user
                BlackedShadowContainer(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: StreamBuilder<bool>(
                      stream:
                          _viewModel.outputIsVideoPlayerControllerInitialized,
                      builder: (context, snapshot) {
                        return Center(
                            child: snapshot.data == true
                                ? Chewie(
                                    controller: _viewModel.mainChewieController,
                                  )
                                : SizedBox.shrink());
                      }),
                ),
                //the add button feature which will allow the user to add another video so that he can merge them together as he wants and produce another video                //after the user adds another video, this video will be displayed
                StreamBuilder<bool>(
                    stream: _viewModel.outputIsAnotherVideoAdded,
                    builder: (context, snapshot) {
                      return snapshot.data == true
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                BlackedShadowContainer(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  child: Chewie(
                                    controller:
                                        _viewModel.secondryChewieController,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),

                                //the discard button feature which will allow the user to discard the second video he added
                                GestureDetector(
                                  onTap: () {
                                    _viewModel.discardSecondVideo();
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: Lottie.asset(
                                      JsonAssets.discard,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : SizedBox.shrink();
                    }),
                //the add button feature which will allow the user to add another video so that he can merge them together as he wants and produce another video
                StreamBuilder<bool>(
                    stream: _viewModel.outputCanAddAnotherVideo,
                    builder: (context, snapshot) {
                      return snapshot.data == true
                          ? GestureDetector(
                              onTap: () {
                                _viewModel.pickAnotherVideo();
                              },
                              child: Container(
                                width: 60,
                                height: 80,
                                child: Lottie.asset(
                                  JsonAssets.addAnotherVideo,
                                ),
                              ),
                            )
                          : SizedBox.shrink();
                    }),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
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
                                        _viewModel.preEditVideo(
                                            _videoEditsTextController);
                                      },
                                      buttonColorCondition:
                                          (snapshot.data ?? false)
                                              ? false
                                              : true,
                                      buttonPressedCondition:
                                          (snapshot.data ?? false)
                                              ? false
                                              : true,
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink();
              }),
          SizedBox(height: 20),
          StreamBuilder<bool>(
              stream: _viewModel.outputIsVideoEdited,
              builder: (context, snapshot) {
                return snapshot.data == true
                    ? ReactiveElevatedButton(
                        text: 'Revert',
                        onPressed: () {
                          _viewModel.revertVideoEdit();
                        },
                        buttonColorCondition:
                            (snapshot.data ?? false) ? false : true,
                        buttonPressedCondition:
                            (snapshot.data ?? false) ? false : true,
                      )
                    : SizedBox.shrink();
              }),
        ],
      ),
    ));
  }
}

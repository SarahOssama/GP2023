import 'package:audima/app/di.dart';
import 'package:audima/presentaion/base/baseview.dart';
import 'package:audima/presentaion/business_video/view/business_video_view_helper.dart';
import 'package:audima/presentaion/business_video/viewModel/business_video_viewModel.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/presentaion/resources/routes_manager.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BusinessVideo extends StatefulWidget {
  @override
  _BusinessVideoState createState() => _BusinessVideoState();
}

class _BusinessVideoState extends State<BusinessVideo> {
  //the view model instance
  late BusinessVideoViewModel _viewModel;
  //view scroll controller
  late ScrollController _scrollController;
  //the speech to text instance
  late stt.SpeechToText _speech;
  late bool _isListening;
  //the text controller for the video edits
  late TextEditingController _videoEditsTextController;
  @override
  void initState() {
    print("business video view init");
    _viewModel = BusinessVideoViewModel(
        instance(), instance(), instance(), instance(), instance());
    _scrollController = ScrollController();
    _videoEditsTextController = TextEditingController();
    _speech = stt.SpeechToText();
    _isListening = false;
    _videoEditsTextController.addListener(() {
      _viewModel.updateVideoEdits(_videoEditsTextController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    print("business video view disposed");
    _videoEditsTextController.removeListener(() {});
    _videoEditsTextController.clear();
    _viewModel.dispose();
    _videoEditsTextController.dispose();

    super.dispose();
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
      },
    );
  }

  Widget _getContentWidget() {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MainScaffold(
        previousRoute: Routes.businessInfo,
        child: SingleChildScrollView(
          controller: _scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 4),
                  scrollDirection: Axis.horizontal,
                  children: [
                    //the main video which will be uploaded first by the user
                    BlackedShadowContainer(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: StreamBuilder<bool>(
                          stream: _viewModel
                              .outputIsVideoPlayerControllerInitialized,
                          builder: (context, snapshot) {
                            return Center(
                                child: snapshot.data == true
                                    ? Chewie(
                                        controller:
                                            _viewModel.mainChewieController,
                                      )
                                    : SizedBox.shrink());
                          }),
                    ),
                    //the add button feature which will allow the user to add another video so that he can merge them together as he wants and produce another video
                    StreamBuilder<bool>(
                        stream: _viewModel.outputCanAddAnotherVideoOrImage,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return snapshot.data == true
                                ? GestureDetector(
                                    onTap: () {
                                      _viewModel.pickAnotherVideoImage();
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
                          } else {
                            return SizedBox.shrink();
                          }
                        }),
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
                                    height: MediaQuery.of(context).size.height /
                                        2.5,
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
                      },
                    ),
                    StreamBuilder<bool>(
                      stream: _viewModel.outputIsAnotherImageAdded,
                      builder: (context, snapshot) {
                        return snapshot.data == true
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  BlackedShadowContainer(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      child:
                                          Image.file(_viewModel.secondryFile)),
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
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
                      ? Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Material(
                                elevation: 50,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextField(
                                    autofocus: false,
                                    controller: _videoEditsTextController,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      filled: true,
                                      hintText: 'Type in your video edits',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  StreamBuilder<bool>(
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
                                                  (snapshot.data ?? false)
                                                      ? false
                                                      : true,
                                              buttonPressedCondition:
                                                  (snapshot.data ?? false)
                                                      ? false
                                                      : true,
                                            )
                                          : SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink();
                },
              ),
              //the voice recognition feature which will allow the user to speak and the app will write what he says in the text field
              //it will depened on 2 bool, the first one which will make it appear or not, the second one will control its working state
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<List<bool>>(
                    stream: _viewModel.outputAudioRecognitionState,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data![0]
                            ? AvatarGlow(
                                animate: snapshot.data![1],
                                glowColor: Theme.of(context).primaryColor,
                                endRadius: 50.0,
                                duration: const Duration(milliseconds: 2000),
                                repeatPauseDuration:
                                    const Duration(milliseconds: 100),
                                repeat: true,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.blueGrey,
                                  onPressed: () {
                                    _viewModel.listenToSpeech(
                                        _videoEditsTextController);
                                  },
                                  child: Icon(_isListening
                                      ? Icons.mic
                                      : Icons.mic_none),
                                ),
                              )
                            : SizedBox.shrink();
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  //this button will be used for proceeding to the final screen which will allow user to preview mission statement and copy it , and also to preview the video and download it
                  StreamBuilder<bool>(
                    stream: _viewModel.outputIsVideoEdited,
                    builder: (context, snapshot) {
                      return snapshot.data == true
                          ? ReactiveElevatedButton(
                              text: 'Proceed',
                              onPressed: () {
                                //go to the final screen

                                Navigator.of(context)
                                    .pushNamed(Routes.finalPresentation);
                              },
                              buttonColorCondition: false,
                              buttonPressedCondition: false,
                            )
                          : SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

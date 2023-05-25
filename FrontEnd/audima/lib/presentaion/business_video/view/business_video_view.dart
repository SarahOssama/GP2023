import 'package:audima/app/di.dart';
import 'package:audima/presentaion/base/baseview.dart';
import 'package:audima/presentaion/business_video/view/business_video_view_helper.dart';
import 'package:audima/presentaion/business_video/viewModel/business_video_viewModel.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BusinessVideo extends StatefulWidget {
  @override
  _BusinessVideoState createState() => _BusinessVideoState();
}

class _BusinessVideoState extends State<BusinessVideo> {
  //the view model instance
  final BusinessVideoViewModel _viewModel = BusinessVideoViewModel(
      instance(), instance(), instance(), instance(), instance());
  //the speech to text instance
  late stt.SpeechToText _speech;
  bool _isListening = false;
  //the text controller for the video edits
  final TextEditingController _videoEditsTextController =
      TextEditingController();
  @override
  void initState() {
    print("dfwquehqw");
    super.initState();
    _speech = stt.SpeechToText();
    _videoEditsTextController.addListener(() {
      _viewModel.updateVideoEdits(_videoEditsTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          print("video");
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
        padding: EdgeInsets.only(top: 50),
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
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: MediaQuery.of(context).size.height /
                                        2.5,
                                    child: Image.file(_viewModel.secondryFile)),
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
                    ? Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ExpandableTextField(
                                textEditingController:
                                    _videoEditsTextController,
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
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),
            //the voice recognition feature which will allow the user to speak and the app will write what he says in the text field
            //it will depened on 2 bool, the first one which will make it appear or not, the second one will control its working state
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
                              _viewModel
                                  .listenToSpeech(_videoEditsTextController);
                            },
                            child:
                                Icon(_isListening ? Icons.mic : Icons.mic_none),
                          ),
                        )
                      : SizedBox.shrink();
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if ("${val}" == "done") {
            setState(() => _isListening = false);
            _speech.stop();
          }
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _videoEditsTextController.text = val.recognizedWords;
            _viewModel.updateVideoEdits(_videoEditsTextController.text);
          }),
          // onSoundLevelChange: (val) {
          //   if (val == 0) {
          //     setState(() => _isListening = false);
          //     _speech.stop();
          //   }
          // },
        );
      }
    } else {
      setState(() {
        _isListening = false;
        print(
            "--------------------------------------------------------------------------");
      });
      _speech.stop();
    }
  }
}

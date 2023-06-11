import 'dart:async';
import 'dart:io';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:audima/app/app_prefrences.dart';
import 'package:audima/app/constants.dart';
import 'package:audima/app/di.dart';
import 'package:audima/domain/usecase/add_voiceover_usecase.dart';
import 'package:audima/domain/usecase/edit_video_usecase.dart';
import 'package:audima/domain/usecase/pre_edit_insert_video_usecase.dart';
import 'package:audima/domain/usecase/pre_edit_video_usecase.dart';
import 'package:audima/domain/usecase/revert_video_edit_usecase.dart';
import 'package:audima/domain/usecase/upload_video_usecase.dart';
import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:audima/presentaion/business_video/viewmodel/pre_edit_confirmation_helper.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/presentaion/resources/routes_manager.dart';
import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:video_player/video_player.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class BusinessVideoViewModel extends BaseViewModel
    with BusinessVideoViewModelInputs, BusinessVideoViewModelOutputs {
  bool isVideoUploaded = false;
  final UploadVideoUseCase _uploadVideoUseCase;
  final EditVideoUseCase _editVideoUseCase;
  final PreEditVideoUseCase _preEditVideoUseCase;
  final PreEditInsertVideoUseCase _preEditInsertVideoUseCase;
  final RevertVideoEditUseCase _revertVideoEditUseCase;
  final AddVoiceOverUseCase _addVoiceOverUseCase;
  BusinessVideoViewModel(
    this._uploadVideoUseCase,
    this._editVideoUseCase,
    this._preEditVideoUseCase,
    this._preEditInsertVideoUseCase,
    this._revertVideoEditUseCase,
    this._addVoiceOverUseCase,
  );
  //------------------------------------------------------------------------------stream controllers
  final StreamController _videoPlayerControllerStreamController =
      StreamController<bool>.broadcast();
  final StreamController _isAnyVideoUploadedStreamController =
      StreamController<bool>.broadcast();
  final StreamController _isVideoEditedStreamController =
      StreamController<bool>.broadcast();
  final StreamController _videoEditsStateStreamController =
      StreamController<bool>.broadcast();
  final StreamController<bool> _isFeatureChangedStreamController =
      StreamController<bool>.broadcast();
  final StreamController<bool> _isAnotherVideoAddedStreamController =
      StreamController<bool>.broadcast();
  final StreamController<bool> _isAnotherImageAddedStreamController =
      StreamController<bool>.broadcast();
  final StreamController<bool> _canAddAnotherVideoOrImageStreamController =
      StreamController<bool>.broadcast();
  final StreamController<List<bool>> _audioRecognitionStateStreamController =
      StreamController<List<bool>>.broadcast();
  //------------------------------------------------------------------------------objects
  var videoEditsObject = VideoEditsObject("");
  //------------------------------------------------------------------------------private controllers
  //main video variables
  late VideoPlayerController mainVideoController;
  late ChewieController mainChewieController;
  //secondry video variables
  late VideoPlayerController secondryVideoController;
  late ChewieController secondryChewieController;
  late File secondryFile;
  bool isSecondVideoAdded = false;
  bool isSecondImageAdded = false;
  //------------------------------------------------------------------------------app preferenecs
  AppPreferences _appPreferences = instance<AppPreferences>();
  //------------------------------------------------------------------------------scroll controllers
  final preEditInnerMenuScrollController =
      ScrollController(initialScrollOffset: 0.0);
  final preEditMenuScrollController =
      ScrollController(initialScrollOffset: 0.0);

  //------------------------------------------------------------------------------add Text Edit Controller
  final editUserTextController = TextEditingController();
  final AudioPlayer audioPlayer = AudioPlayer();
  bool audioPLayerStatus = false;
  int audioPlayerValue = 0;
  //------------------------------------------------------------------------------audio recognition variables
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListeningToSpeech = false;

  @override
  void start() {
    inputIsAnyVideoUploaded.add(false);
    // inputState.add(ContentState());
  }

  @override
  void dispose() {
    _videoPlayerControllerStreamController.close();
    _isAnyVideoUploadedStreamController.close();
    _videoEditsStateStreamController.close();
    _isVideoEditedStreamController.close();
    _isFeatureChangedStreamController.close();
    _isAnotherVideoAddedStreamController.close();
    _canAddAnotherVideoOrImageStreamController.close();
    editUserTextController.dispose();
    _audioRecognitionStateStreamController.close();
    _isAnotherImageAddedStreamController.close();

    super.dispose();
  }

  //------------------------------------------------------------------------------video player orders
  @override
  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      if (isVideoUploaded) {
        inputIsVideoPlayerControllerInitialized.add(false);
      }

      inputState.add(LoadingState(
          stateRendererType: StateRendererType.popUpLoadingState,
          message: "Uploading your Video"));
      File file = File(result.files.single.path!);
      (await _uploadVideoUseCase.execute(UploadVideoUseCaseInput(file))).fold(
          (failure) {
        inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message));

        //left means failure
      }, (data) async {
        //remove revert video edit button as it is the first video upload
        inputIsVideoEdited.add(false);
        //right means success
        mainVideoController = VideoPlayerController.file(file);
        await Future.wait([mainVideoController.initialize()]);
        mainChewieController = ChewieController(
          autoInitialize: true,
          videoPlayerController: mainVideoController,
          autoPlay: true,
          aspectRatio: mainVideoController.value.aspectRatio,
        );
        if (isVideoUploaded == false) {
          inputCanAddAnotherVideoOrImage.add(true);
        }
        inputIsVideoPlayerControllerInitialized.add(true);
        inputIsAnyVideoUploaded.add(true);
        inputAudioRecognitionState.add([
          true,
          isListeningToSpeech,
        ]);
        isVideoUploaded = true;
        inputState.add(ContentState());
      });
    }
  }

  @override
  Future<void> pickAnotherVideoImage(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'jpg', 'png', 'jpeg'],
    );
    if (result != null) {
      inputState.add(
        ConfirmationState(
          cancelActionFunction: Navigator.of(context).pop,
          message: result.files.single.extension == 'mp4'
              ? "Adding video for further Merges"
              : "Adding Image for further Merges",
          confirmText: "Confirm",
          cancelText: "Cancel",
          listView: const SizedBox.shrink(),
          stateRendererType: StateRendererType.popUpConfirmationState,
          confirmationActionFunction: () async {
            File file = File(result.files.single.path!);
            secondryFile = file;
            result.files.single.extension == 'mp4'
                ? isSecondVideoAdded = true
                : isSecondImageAdded = true;
            //if the file is a video then do the follwing
            result.files.single.extension == 'mp4'
                ? initializeSecondVideo()
                : inputIsAnotherImageAdded.add(true);

            inputCanAddAnotherVideoOrImage.add(false);
            inputState.add(ContentState());
          },
        ),
      );
    }
  }

  @override
  void discardSecondVideo(BuildContext context) {
    inputState.add(ConfirmationState(
        cancelActionFunction: Navigator.of(context).pop,
        listView: const SizedBox.shrink(),
        message: "Discard Second Added Video",
        confirmText: "Confirm",
        cancelText: "Cancel",
        stateRendererType: StateRendererType.popUpConfirmationState,
        confirmationActionFunction: () {
          removeSecondVideoOrImage();
          inputState.add(ContentState());
        }));
  }

  @override
  Future<void> preEditVideo(
      TextEditingController textEditingController, BuildContext context) async {
    //pause the main video
    mainVideoController.pause();
    //if there is another video pause it too
    isSecondVideoAdded ? secondryVideoController.pause() : null;
    //show loading state of processing the edit command
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popUpLoadingState,
        message: "Processing your Edit Command"));
    //if another video is added then call pre edit insert api else call pre edit api
    (isSecondVideoAdded || isSecondImageAdded
            ? await _preEditInsertVideoUseCase.execute(
                PreEditInsertVideoUseCaseInput(
                    textEditingController.text, secondryFile))
            : await _preEditVideoUseCase
                .execute(PreEditVideoUseCaseInput(textEditingController.text)))
        .fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popUpErrorState, failure.message));
      //left means failure
    }, (data) {
      //case add text feature->remove the lists from the data.features
      List<dynamic> listOfAvailableColors = [];
      List<dynamic> listOfAvailableSizes = [];
      List<dynamic> listOfAvailablePositions = [];
      if (data.action == "Add Text") {
        editUserTextController.text = data.features["text"];
        listOfAvailableColors = data.features.remove("listOfAvailableColors");
        listOfAvailableSizes = data.features.remove("listOfAvailableSizes");
        listOfAvailablePositions =
            data.features.remove("listOfAvailablePositions");
      }
      inputState.add(
        ConfirmationState(
            cancelActionFunction: Navigator.of(context).pop,
            stateRendererType: StateRendererType.popUpConfirmationState,
            message: data.message,
            confirmText: "Confirm",
            cancelText: "Cancel",
            confirmationActionFunction: () async {
              data.action == "Add Text"
                  ? data.features["text"] = editUserTextController.text
                  : null;
              await editVideo(
                  textEditingController, data.action, data.features);
            },
            listView: Column(
              children: [
                ListTile(
                  title: Text("action"),
                  subtitle: Text(data.action.toString()),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: AdaptiveScrollbar(
                    sliderSpacing: const EdgeInsets.all(5.0),
                    width: 15,
                    sliderDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    controller: preEditMenuScrollController,
                    child: ListView.builder(
                      controller: preEditMenuScrollController,
                      shrinkWrap: true,
                      itemCount: data.features.entries.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(
                                data.features.entries.elementAt(index).key),
                            subtitle: data.features.entries
                                        .elementAt(index)
                                        .key !=
                                    "text"
                                ? StreamBuilder<bool>(
                                    stream: _isFeatureChangedStreamController
                                        .stream,
                                    builder: (context, snapshot) {
                                      return Text(data.features.entries
                                                  .elementAt(index)
                                                  .value
                                                  .runtimeType !=
                                              String
                                          ? data.features.entries
                                              .elementAt(index)
                                              .value
                                              .toStringAsFixed(1)
                                          : data.features.entries
                                              .elementAt(index)
                                              .value);
                                    })
                                : TextField(
                                    controller: editUserTextController,
                                  ),
                            trailing: FeatureTrailing(
                                action: data.action,
                                featureKey:
                                    data.features.entries.elementAt(index).key,
                                features: data.features,
                                videoDuration: data.videoDuration,
                                objectIndex: index,
                                editUserTextController: editUserTextController,
                                listOfAvailableColors:
                                    listOfAvailableColors.cast<String>(),
                                listOfAvailableSizes:
                                    listOfAvailableSizes.cast<String>(),
                                listOfAvailablePositions:
                                    listOfAvailablePositions.cast<String>(),
                                onFteaureChanged: () {
                                  _isFeatureChangedStreamController.add(true);
                                }));
                      },
                    ),
                  ),
                ),
              ],
            )),
      );
    });
  }

  @override
  Future<void> editVideo(TextEditingController textEditingController,
      String action, Map<String, dynamic> features) async {
    //pause the main video
    mainVideoController.pause();
    //if there is another video pause it too
    isSecondVideoAdded ? secondryVideoController.pause() : null;
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popUpLoadingState,
        message: "Editing your Video",
      ),
    );
    (await _editVideoUseCase.execute(
      EditVideoUseCaseInput(action, features),
    ))
        .fold((failure) {
      mainVideoController.play();
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          failure.message,
        ),
      );

      //left means failure
    }, (data) async {
      //right means success

      mainVideoController.removeListener(() {});
      mainVideoController.dispose();
      mainChewieController.dispose();
      textEditingController.clear();
      mainVideoController = VideoPlayerController.network(
          "${Constants.videoManipulationUrl}${data.videoUrl}");

      await Future.wait([mainVideoController.initialize()]);

      mainChewieController = ChewieController(
        autoInitialize: true,
        videoPlayerController: mainVideoController,
        autoPlay: true,
        aspectRatio: mainVideoController.value.aspectRatio,
      );

      inputIsVideoPlayerControllerInitialized.add(true);
      inputIsAnyVideoUploaded.add(true);
      //remove second video added if any or second image added if any
      (isSecondVideoAdded || isSecondImageAdded)
          ? removeSecondVideoOrImage()
          : null;
      //now the video is edited so we can do multiple things, first is proceeding with next screen and second is reverting the video edit, also i save the video url to app preferences
      _appPreferences
          .setVideoUrl("${Constants.videoManipulationUrl}${data.videoUrl}");
      inputIsVideoEdited.add(true);

      inputState.add(ContentState());
    });
  }

  @override
  Future<void> revertVideoEdit() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popUpLoadingState,
        message: "Reverting your Video Edit",
      ),
    );
    (await _revertVideoEditUseCase.execute(RevertVideoEditUseCaseInput())).fold(
        (failure) {
      mainVideoController.play();
      //remove revert video edit button as no more reverts can be done
      inputIsVideoEdited.add(false);

      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          failure.message,
        ),
      );

      //left means failure
    }, (data) async {
      mainVideoController.removeListener(() {});
      mainVideoController.dispose();
      mainChewieController.dispose();
      mainVideoController = VideoPlayerController.network(
          "${Constants.videoManipulationUrl}${data.videoUrl}");
      await Future.wait([mainVideoController.initialize()]);
      mainChewieController = ChewieController(
        autoInitialize: true,
        videoPlayerController: mainVideoController,
        autoPlay: true,
        aspectRatio: mainVideoController.value.aspectRatio,
      );
      //save the reverted video url to app preferences
      _appPreferences
          .setVideoUrl("${Constants.videoManipulationUrl}${data.videoUrl}");
      inputIsVideoPlayerControllerInitialized.add(true);
      inputIsAnyVideoUploaded.add(true);
      inputIsVideoEdited.add(true);
      //right means success
      inputState.add(ContentState());
    });
  }

  @override
  Future<void> addVoiceOver(BuildContext context) async {
    //pause the main video
    mainVideoController.pause();
    //add confirmation state
    inputState.add(
      ConfirmationState(
        stateRendererType: StateRendererType.popUpConfirmationState,
        listView: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text("background music 1 "),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          audioPlayer
                              .play(AssetSource("audios/Background1.mp3"));
                          audioPLayerStatus = true;
                          audioPlayerValue = 1;
                        },
                        icon: Icon(Icons.play_arrow_outlined)),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text("background music 2 "),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          audioPlayer
                              .play(AssetSource("audios/Background2.mp3"));
                          audioPLayerStatus = true;
                          audioPlayerValue = 2;
                        },
                        icon: Icon(Icons.play_arrow_outlined)),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text("background music 3 "),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          audioPlayer
                              .play(AssetSource("audios/Background3.mp3"));
                          audioPLayerStatus = true;
                          audioPlayerValue = 3;
                        },
                        icon: Icon(Icons.play_arrow_outlined)),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text("background music 4 "),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          audioPlayer
                              .play(AssetSource("audios/Background4.mp3"));
                          audioPLayerStatus = true;
                          audioPlayerValue = 4;
                        },
                        icon: Icon(Icons.play_arrow_outlined)),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text("background music 5 "),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          audioPlayer
                              .play(AssetSource("audios/Background5.mp3"));
                          audioPLayerStatus = true;
                          audioPlayerValue = 5;
                        },
                        icon: Icon(Icons.play_arrow_outlined)),
                  )
                ],
              ),
            ],
          ),
        ),
        message:
            "Wohoo!! We are done editing you video, so do you want to add background music for your video",
        cancelText: "No",
        confirmText: "Yes",
        cancelActionFunction: () {
          audioPlayer.pause();
          inputState.add(ContentState());
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(context).pushNamed(Routes.finalPresentation);
          });
        },
        confirmationActionFunction: () async {
          audioPlayer.pause();
          inputState.add(
            LoadingState(
                stateRendererType: StateRendererType.popUpLoadingState,
                message: "Adding voice over"),
          );
          (await _addVoiceOverUseCase
                  .execute(AddVoiceOverUseCaseInput(audioPlayerValue)))
              .fold((failure) {
            inputState.add(
                ErrorState(StateRendererType.popUpErrorState, failure.message));
            //left means failure
          }, (data) {
            _appPreferences
                .setVideoUrl(
                    "${Constants.videoManipulationUrl}${data.videoUrl}")
                .then(
                  (value) => {
                    audioPlayer.pause(),
                    mainChewieController.pause(),
                    inputState.add(ContentState()),
                    SchedulerBinding.instance!.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamed(Routes.finalPresentation);
                    }),
                  },
                );
          });
        },
      ),
    );
  }

  @override
  void updateVideoEdits(String videoEdits) {
    videoEditsObject = videoEditsObject.copyWith(videoEdits: videoEdits);
    videoEditsObject.videoEdits == ""
        ? inputVideoEditsState.add(false)
        : inputVideoEditsState.add(true);
  }
  //------------------------------------------------------------------------------audio recognition orders

  @override
  void listenToSpeech(TextEditingController textEditingController) async {
    if (!isListeningToSpeech) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if ("${val}" == "done") {
            isListeningToSpeech = false;
            inputAudioRecognitionState.add([
              true,
              isListeningToSpeech,
            ]);

            _speech.stop();
          }
        },
        onError: (val) => print('onError: $val'),
      );

      await Future.delayed(Duration(milliseconds: 100)); // Add a delay here

      if (available) {
        isListeningToSpeech = true;
        inputAudioRecognitionState.add([
          true,
          isListeningToSpeech,
        ]);
        _speech.listen(
          onResult: (val) {
            textEditingController.text = val.recognizedWords;
            updateVideoEdits(textEditingController.text);
          },
        );
      }
    } else {
      isListeningToSpeech = false;
      inputAudioRecognitionState.add([
        true,
        isListeningToSpeech,
      ]);
      _speech.stop();
    }
  }

  //------------------------------------------------------------------------------------------helper functions
  void removeSecondVideoOrImage() {
    isSecondVideoAdded ? secondryVideoController.dispose() : null;
    isSecondVideoAdded ? secondryChewieController.dispose() : null;
    inputCanAddAnotherVideoOrImage.add(true);
    inputIsAnotherVideoAdded.add(false);
    inputIsAnotherImageAdded.add(false);
    isSecondVideoAdded = false;
    isSecondImageAdded = false;
  }

  void initializeSecondVideo() async {
    secondryVideoController = VideoPlayerController.file(secondryFile);
    await Future.wait([secondryVideoController.initialize()]);
    secondryChewieController = ChewieController(
      autoInitialize: true,
      videoPlayerController: secondryVideoController,
      autoPlay: true,
      aspectRatio: secondryVideoController.value.aspectRatio,
    );

    inputIsAnotherVideoAdded.add(true);
  }

  //------------------------------------------------------------------------------video player streams
  @override
  Sink get inputIsVideoPlayerControllerInitialized =>
      _videoPlayerControllerStreamController.sink;

  @override
  Stream<bool> get outputIsVideoPlayerControllerInitialized =>
      _videoPlayerControllerStreamController.stream.map((cond) => cond);

  @override
  Sink get inputIsAnyVideoUploaded => _isAnyVideoUploadedStreamController.sink;

  @override
  Stream<bool> get outputIsAnyVideoUploaded =>
      _isAnyVideoUploadedStreamController.stream.map((cond) => cond);
  //------------------------------------------------------------------------------button streams
  @override
  Sink get inputVideoEditsState => _videoEditsStateStreamController.sink;

  @override
  Stream<bool> get outputVideoEditsState =>
      _videoEditsStateStreamController.stream.map((cond) => cond);

  @override
  Sink get inputIsVideoEdited => _isVideoEditedStreamController.sink;

  @override
  Stream<bool> get outputIsVideoEdited =>
      _isVideoEditedStreamController.stream.map((cond) => cond);
  //------------------------------------------------------------------------------add another video or image streams

  @override
  Sink get inputCanAddAnotherVideoOrImage =>
      _canAddAnotherVideoOrImageStreamController.sink;

  @override
  Sink get inputIsAnotherVideoAdded =>
      _isAnotherVideoAddedStreamController.sink;
  @override
  Sink get inputIsAnotherImageAdded =>
      _isAnotherImageAddedStreamController.sink;

  @override
  Stream<bool> get outputIsAnotherImageAdded =>
      _isAnotherImageAddedStreamController.stream.map((cond) => cond);
  @override
  Stream<bool> get outputCanAddAnotherVideoOrImage =>
      _canAddAnotherVideoOrImageStreamController.stream.map((cond) => cond);

  @override
  Stream<bool> get outputIsAnotherVideoAdded =>
      _isAnotherVideoAddedStreamController.stream.map((cond) => cond);

  //------------------------------------------------------------------------------audio recognition streams
  @override
  Sink get inputAudioRecognitionState =>
      _audioRecognitionStateStreamController.sink;

  @override
  Stream<List<bool>> get outputAudioRecognitionState =>
      _audioRecognitionStateStreamController.stream.map((cond) => cond);
  //------------------------------------------------------------------------------------------helper functions

  void _updateVideoPlayerController() {
    mainChewieController.videoPlayerController.value.isInitialized
        ? inputIsVideoPlayerControllerInitialized.add(true)
        : inputIsVideoPlayerControllerInitialized.add(false);
  }
}

//------------------------------------------------------------------------------inputs and orders
abstract class BusinessVideoViewModelInputs {
  //orders
  Future<void> pickVideo();
  Future<void> pickAnotherVideoImage(BuildContext context);
  void discardSecondVideo(BuildContext context);
  Future<void> editVideo(TextEditingController textEditingController,
      String action, Map<String, dynamic> features);
  Future<void> preEditVideo(
      TextEditingController textEditingController, BuildContext context);
  Future<void> revertVideoEdit();
  Future<void> addVoiceOver(BuildContext context);
  updateVideoEdits(String videoEdits);
  //audio listner
  void listenToSpeech(TextEditingController textEditingController);

  //stream inputs
  Sink get inputIsVideoPlayerControllerInitialized;
  Sink get inputIsAnyVideoUploaded;
  Sink get inputVideoEditsState;
  Sink get inputIsVideoEdited;
  Sink get inputIsAnotherVideoAdded;
  Sink get inputIsAnotherImageAdded;
  Sink get inputCanAddAnotherVideoOrImage;
  Sink get inputAudioRecognitionState;
}

//------------------------------------------------------------------------------outputs
abstract class BusinessVideoViewModelOutputs {
  //stream outputs
  Stream<bool> get outputIsVideoPlayerControllerInitialized;
  Stream<bool> get outputIsAnyVideoUploaded;
  Stream<bool> get outputVideoEditsState;
  Stream<bool> get outputIsVideoEdited;
  Stream<bool> get outputIsAnotherVideoAdded;
  Stream<bool> get outputIsAnotherImageAdded;
  Stream<bool> get outputCanAddAnotherVideoOrImage;
  Stream<List<bool>> get outputAudioRecognitionState;
}

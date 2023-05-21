import 'dart:async';
import 'dart:io';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:audima/app/constants.dart';
import 'package:audima/domain/usecase/edit_video_usecase.dart';
import 'package:audima/domain/usecase/pre_edit_video_usecase.dart';
import 'package:audima/domain/usecase/revert_video_edit_usecase.dart';
import 'package:audima/domain/usecase/upload_video_usecase.dart';
import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:audima/presentaion/business_video/viewmodel/pre_edit_confirmation_helper.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:chewie/chewie.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class BusinessVideoViewModel extends BaseViewModel
    with BusinessVideoViewModelInputs, BusinessVideoViewModelOutputs {
  bool isVideoUploaded = false;
  final UploadVideoUseCase _uploadVideoUseCase;
  final EditVideoUseCase _editVideoUseCase;
  final PreEditVideoUseCase _preEditVideoUseCase;
  final RevertVideoEditUseCase _revertVideoEditUseCase;
  BusinessVideoViewModel(this._uploadVideoUseCase, this._editVideoUseCase,
      this._preEditVideoUseCase, this._revertVideoEditUseCase);
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
  final StreamController<bool> _canAddAnotherVideoStreamController =
      StreamController<bool>.broadcast();
  //------------------------------------------------------------------------------objects
  var videoEditsObject = VideoEditsObject("");
  //------------------------------------------------------------------------------private controllers
  late VideoPlayerController mainVideoController;
  late ChewieController mainChewieController;
  late VideoPlayerController secondryVideoController;
  late ChewieController secondryChewieController;
  final preEditInnerMenuScrollController =
      ScrollController(initialScrollOffset: 0.0);
  final preEditMenuScrollController =
      ScrollController(initialScrollOffset: 0.0);

  //------------------------------------------------------------------------------add Text Edit Controller
  final editUserTextController = TextEditingController();

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
    _canAddAnotherVideoStreamController.close();
    mainVideoController.dispose();
    mainChewieController.dispose();
    secondryVideoController.dispose();
    secondryChewieController.dispose();
    editUserTextController.dispose();

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
          looping: true,
          aspectRatio: mainVideoController.value.aspectRatio,
        );
        inputIsVideoPlayerControllerInitialized.add(true);
        inputIsAnyVideoUploaded.add(true);
        inputCanAddAnotherVideo.add(true);
        isVideoUploaded = true;
        inputState.add(ContentState());
      });
    }
  }

  @override
  Future<void> pickAnotherVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      inputState.add(ConfirmationState(
          message: "Add Another Video",
          listView: const SizedBox.shrink(),
          stateRendererType: StateRendererType.popUpConfirmationState,
          confirmationActionFunction: () async {
            File file = File(result.files.single.path!);
            secondryVideoController = VideoPlayerController.file(file);
            await Future.wait([secondryVideoController.initialize()]);
            secondryChewieController = ChewieController(
              autoInitialize: true,
              videoPlayerController: secondryVideoController,
              autoPlay: true,
              looping: true,
              aspectRatio: secondryVideoController.value.aspectRatio,
            );
            inputState.add(ContentState());
            inputCanAddAnotherVideo.add(false);
            inputIsAnotherVideoAdded.add(true);
          }));
    }
  }

  @override
  void discardSecondVideo() {
    inputState.add(ConfirmationState(
        listView: const SizedBox.shrink(),
        message: "Discard Second Added Video",
        stateRendererType: StateRendererType.popUpConfirmationState,
        confirmationActionFunction: () {
          secondryVideoController.dispose();
          secondryChewieController.dispose();
          inputIsAnotherVideoAdded.add(false);
          inputCanAddAnotherVideo.add(true);
          inputState.add(ContentState());
        }));
  }

  @override
  Future<void> preEditVideo(TextEditingController textEditingController) async {
    mainVideoController.pause();
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popUpLoadingState,
        message: "Processing your Edit Command"));
    (await _preEditVideoUseCase
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
            stateRendererType: StateRendererType.popUpConfirmationState,
            message: data.message,
            confirmationActionFunction: () {
              data.action == "Add Text"
                  ? data.features["text"] = editUserTextController.text
                  : null;
              editVideo(textEditingController, data.action, data.features);
            },
            listView: Column(
              children: [
                ListTile(
                  title: Text("action"),
                  subtitle: Text(data.action.toString()),
                ),
                Container(
                  height: 200,
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
                            trailing:
                                data.features.entries.elementAt(index).key !=
                                        "text"
                                    ? DropdownButtonHideUnderline(
                                        child: PopupMenuButton(
                                          padding: EdgeInsets.zero,
                                          icon: null,
                                          iconSize: 0,
                                          itemBuilder: (BuildContext context) {
                                            return [
                                              PopupMenuItem(
                                                padding: EdgeInsets.zero,
                                                child: Container(
                                                  height:
                                                      130, // Set the desired height for the menu
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Scrollbar(
                                                          controller:
                                                              preEditInnerMenuScrollController,
                                                          thumbVisibility: true,
                                                          child:
                                                              SingleChildScrollView(
                                                            controller:
                                                                preEditInnerMenuScrollController,
                                                            physics:
                                                                AlwaysScrollableScrollPhysics(),
                                                            child: Column(
                                                                children: [
                                                                  ActiobEditMenuItems(
                                                                      videoDuration:
                                                                          data
                                                                              .videoDuration,
                                                                      index:
                                                                          index,
                                                                      features: data
                                                                          .features,
                                                                      listOfAvailableColors:
                                                                          listOfAvailableColors.cast<
                                                                              String>(),
                                                                      listOfAvailableSizes:
                                                                          listOfAvailableSizes.cast<
                                                                              String>(),
                                                                      listOfAvailablePositions:
                                                                          listOfAvailablePositions
                                                                              .cast<String>())
                                                                ]),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ];
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            child: Lottie.asset(
                                              JsonAssets.edit,
                                            ),
                                          ),
                                          onSelected: (value) {
                                            //check if end time choosen is equal to start time//then decrease start time by 1
                                            data.features[data.features.entries
                                                .elementAt(index)
                                                .key] = value;
                                            _isFeatureChangedStreamController
                                                .add(true);
                                          },
                                        ),
                                      )
                                    : SizedBox.shrink());
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
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popUpLoadingState,
        message: "Editing your Video",
      ),
    );
    mainVideoController.pause();
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
        looping: true,
        aspectRatio: mainVideoController.value.aspectRatio,
      );
      inputIsVideoPlayerControllerInitialized.add(true);
      inputIsAnyVideoUploaded.add(true);
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
    mainVideoController.pause();
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
      //right means success
      inputState.add(ContentState());
      mainVideoController.dispose();
      mainChewieController.dispose();
      mainVideoController = VideoPlayerController.network(
          "${Constants.videoManipulationUrl}${data.videoUrl}");
      await Future.wait([mainVideoController.initialize()]);
      mainChewieController = ChewieController(
        autoInitialize: true,
        videoPlayerController: mainVideoController,
        autoPlay: true,
        looping: true,
        aspectRatio: mainVideoController.value.aspectRatio,
      );
      inputIsVideoPlayerControllerInitialized.add(true);
      inputIsAnyVideoUploaded.add(true);
      inputIsVideoEdited.add(true);
    });
  }

  @override
  void updateVideoEdits(String videoEdits) {
    print("text controller listener");
    videoEditsObject = videoEditsObject.copyWith(videoEdits: videoEdits);
    videoEditsObject.videoEdits == ""
        ? inputVideoEditsState.add(false)
        : inputVideoEditsState.add(true);
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
  //------------------------------------------------------------------------------add another video streams

  @override
  Sink get inputCanAddAnotherVideo => _canAddAnotherVideoStreamController.sink;

  @override
  Sink get inputIsAnotherVideoAdded =>
      _isAnotherVideoAddedStreamController.sink;

  @override
  Stream<bool> get outputCanAddAnotherVideo =>
      _canAddAnotherVideoStreamController.stream.map((cond) => cond);

  @override
  Stream<bool> get outputIsAnotherVideoAdded =>
      _isAnotherVideoAddedStreamController.stream.map((cond) => cond);
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
  Future<void> pickAnotherVideo();
  void discardSecondVideo();
  Future<void> editVideo(TextEditingController textEditingController,
      String action, Map<String, dynamic> features);
  Future<void> preEditVideo(TextEditingController textEditingController);
  Future<void> revertVideoEdit();
  updateVideoEdits(String videoEdits);

  //stream inputs
  Sink get inputIsVideoPlayerControllerInitialized;
  Sink get inputIsAnyVideoUploaded;
  Sink get inputVideoEditsState;
  Sink get inputIsVideoEdited;
  Sink get inputIsAnotherVideoAdded;
  Sink get inputCanAddAnotherVideo;
}

//------------------------------------------------------------------------------outputs
abstract class BusinessVideoViewModelOutputs {
  //stream outputs
  Stream<bool> get outputIsVideoPlayerControllerInitialized;
  Stream<bool> get outputIsAnyVideoUploaded;
  Stream<bool> get outputVideoEditsState;
  Stream<bool> get outputIsVideoEdited;
  Stream<bool> get outputIsAnotherVideoAdded;
  Stream<bool> get outputCanAddAnotherVideo;
}

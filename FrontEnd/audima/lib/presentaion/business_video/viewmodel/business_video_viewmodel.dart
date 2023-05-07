import 'dart:async';
import 'dart:io';

import 'package:audima/app/constants.dart';
import 'package:audima/domain/usecase/edit_video_usecase.dart';
import 'package:audima/domain/usecase/upload_video_usecase.dart';
import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BusinessVideoViewModel extends BaseViewModel
    with BusinessVideoViewModelInputs, BusinessVideoViewModelOutputs {
  late VideoPlayerController controller;
  bool isVideoUploaded = false;
  final UploadVideoUseCase _uploadVideoUseCase;
  final EditVideoUseCase _editVideoUseCase;
  BusinessVideoViewModel(this._uploadVideoUseCase, this._editVideoUseCase);
  //------------------------------------------------------------------------------stream controllers
  final StreamController _videoPlayerControllerStreamController =
      StreamController<bool>.broadcast();
  final StreamController _isAnyVideoUploadedStreamController =
      StreamController<bool>.broadcast();

  final StreamController _videoEditsStateStreamController =
      StreamController<bool>.broadcast();
  //------------------------------------------------------------------------------objects
  var videoEditsObject = VideoEditsObject("");

  @override
  void start() {
    inputState.add(ContentState());
  }

  //------------------------------------------------------------------------------video player orders
  @override
  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(
      type: FileType.video,
    )
        .then((result) async {
      if (result != null) {
        if (isVideoUploaded) {
          controller.dispose();
          inputIsVideoPlayerControllerInitialized.add(false);
        }
        isVideoUploaded = true;
        inputState.add(LoadingState(
            stateRendererType: StateRendererType.popUpLoadingState,
            message: "Uploading your Video"));
        File file = File(result.files.single.path!);
        await _uploadVideo(file, "ss");
        controller = VideoPlayerController.file(file)
          ..initialize().then((_) {})
          ..addListener(() {
            _updateVideoPlayerController();
          })
          ..play();
        inputState.add(ContentState());
        inputIsAnyVideoUploaded.add(true);
      }
    });
  }

  @override
  void updateVideoEdits(String videoEdits) {
    videoEditsObject = videoEditsObject.copyWith(videoEdits: videoEdits);
    videoEditsObject.videoEdits == ""
        ? inputVideoEditsState.add(false)
        : inputVideoEditsState.add(true);
  }

  @override
  void editVideo(TextEditingController textEditingController) {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popUpLoadingState,
        message: "Editing your Video"));
    _editVideo(videoEditsObject.videoEdits, textEditingController);
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

  //------------------------------------------------------------------------------------------helper functions
  Future<void> _uploadVideo(File video, String caption) async {
    (await _uploadVideoUseCase.execute(UploadVideoUseCaseInput(video, caption)))
        .fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popUpErrorState, failure.message));

      //left means failure
    }, (data) {
      //right means success
    });
  }

  Future<void> _editVideo(
      String command, TextEditingController textEditingController) async {
    (await _editVideoUseCase.execute(EditVideoUseCaseInput(command))).fold(
        (failure) {
      inputState
          .add(ErrorState(StateRendererType.popUpErrorState, failure.message));

      //left means failure
    }, (data) {
      //right means success
      controller.pause();

      controller.dispose();
      textEditingController.clear();
      controller = VideoPlayerController.network(
          "${Constants.videoManipulationUrl}${data.videoUrl}")
        ..initialize().then((_) {})
        ..addListener(() {
          _updateVideoPlayerController();
        })
        ..play();
      inputState.add(ContentState());
      inputIsAnyVideoUploaded.add(true);
    });
  }

  void _updateVideoPlayerController() {
    controller.value.isInitialized
        ? inputIsVideoPlayerControllerInitialized.add(true)
        : inputIsVideoPlayerControllerInitialized.add(false);
  }
}

//------------------------------------------------------------------------------inputs and orders
abstract class BusinessVideoViewModelInputs {
  //orders
  Future<void> pickVideo();
  void updateVideoEdits(String videoEdits);
  void editVideo(TextEditingController textEditingController);

  //stream inputs
  Sink get inputIsVideoPlayerControllerInitialized;
  Sink get inputIsAnyVideoUploaded;
  Sink get inputVideoEditsState;
}

//------------------------------------------------------------------------------outputs
abstract class BusinessVideoViewModelOutputs {
  //stream outputs
  Stream<bool> get outputIsVideoPlayerControllerInitialized;
  Stream<bool> get outputIsAnyVideoUploaded;
  Stream<bool> get outputVideoEditsState;
}

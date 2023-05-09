import 'dart:async';
import 'dart:io';

import 'package:audima/app/constants.dart';
import 'package:audima/domain/usecase/edit_video_usecase.dart';
import 'package:audima/domain/usecase/upload_video_usecase.dart';
import 'package:audima/presentaion/base/baseview.dart';
import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BusinessVideoViewModel extends BaseViewModel
    with BusinessVideoViewModelInputs, BusinessVideoViewModelOutputs {
  late VideoPlayerController controller;
  late ChewieController chewieController;
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
    inputIsAnyVideoUploaded.add(false);
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _videoPlayerControllerStreamController.close();
    _isAnyVideoUploadedStreamController.close();
    _videoEditsStateStreamController.close();
    controller.dispose();
    chewieController.dispose();

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
        // controller.dispose();
        // chewieController.dispose();
        inputIsVideoPlayerControllerInitialized.add(false);
      }

      inputState.add(LoadingState(
          stateRendererType: StateRendererType.popUpLoadingState,
          message: "Uploading your Video"));
      File file = File(result.files.single.path!);
      (await _uploadVideoUseCase.execute(UploadVideoUseCaseInput(file, "ss")))
          .fold((failure) {
        inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message));

        //left means failure
      }, (data) async {
        //right means success
        controller = VideoPlayerController.file(file);
        await Future.wait([controller.initialize()]);
        chewieController = ChewieController(
          autoInitialize: true,
          videoPlayerController: controller,
          autoPlay: true,
          looping: true,
          aspectRatio: controller.value.aspectRatio,
        );
        inputIsVideoPlayerControllerInitialized.add(true);
        inputIsAnyVideoUploaded.add(true);
        inputState.add(ContentState());
        isVideoUploaded = true;
      });
    }
  }

  @override
  Future<void> editVideo(TextEditingController textEditingController) async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popUpLoadingState,
        message: "Editing your Video",
      ),
    );
    controller.pause();
    (await _editVideoUseCase.execute(
      EditVideoUseCaseInput(videoEditsObject.videoEdits),
    ))
        .fold((failure) {
      controller.play();
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          failure.message,
        ),
      );

      //left means failure
    }, (data) async {
      //right means success
      // controller.dispose();
      // chewieController.dispose();
      textEditingController.clear();
      controller = VideoPlayerController.network(
          "${Constants.videoManipulationUrl}${data.videoUrl}");
      await Future.wait([controller.initialize()]);
      chewieController = ChewieController(
        autoInitialize: true,
        videoPlayerController: controller,
        autoPlay: true,
        looping: true,
        aspectRatio: controller.value.aspectRatio,
      );
      inputIsVideoPlayerControllerInitialized.add(true);
      inputIsAnyVideoUploaded.add(true);
      inputState.add(ContentState());
    });
  }

  @override
  void updateVideoEdits(String videoEdits) {
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

  //------------------------------------------------------------------------------------------helper functions
  Future<void> _uploadVideo(File video, String caption) async {}

  Future<void> _editVideo(
      String command, TextEditingController textEditingController) async {
    controller.pause();
    (await _editVideoUseCase.execute(EditVideoUseCaseInput(command))).fold(
        (failure) {
      controller.play();
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
        ..play()
        ..setLooping(true);
      chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: true,
        looping: true,
        showControls: true,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: false,
        allowMuting: false,
        showOptions: false,
        showControlsOnInitialize: false,
        aspectRatio: 16 / 9,
        autoInitialize: true,
      );
      inputState.add(ContentState());
      inputIsAnyVideoUploaded.add(true);
    });
  }

  void _updateVideoPlayerController() {
    chewieController.videoPlayerController.value.isInitialized
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

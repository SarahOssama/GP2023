import 'dart:async';
import 'dart:io';

import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';

class BusinessVideoViewModel extends BaseViewModel
    with BusinessVideoViewModelInputs, BusinessVideoViewModelOutputs {
  late VideoPlayerController controller;
  //------------------------------------------------------------------------------stream controllers
  final StreamController _videoPlayerControllerStreamController =
      StreamController<bool>.broadcast();
  final StreamController _isAnyVideoUploadedStreamController =
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
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popUpLoadingState,
        message: "Loading your Video"));
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      controller = VideoPlayerController.file(file)
        ..initialize().then((_) {})
        ..addListener(() {
          updateVideoPlayerController();
        })
        ..play();
      inputState.add(ContentState());
      inputIsAnyVideoUploaded.add(true);
    }
  }

  @override
  void updateVideoPlayerController() {
    controller.value.isInitialized
        ? inputIsVideoPlayerControllerInitialized.add(true)
        : inputIsVideoPlayerControllerInitialized.add(false);
  }

  @override
  void updateVideoEdits(String videoEdits) {
    videoEditsObject = videoEditsObject.copyWith(videoEdits: videoEdits);
    print(videoEditsObject.videoEdits);
  }

  @override
  void editVideo() {}
  //------------------------------------------------------------------------------video player streams
  @override
  // TODO: implement inputVideoPlayerController
  Sink get inputIsVideoPlayerControllerInitialized =>
      _videoPlayerControllerStreamController.sink;

  @override
  // TODO: implement outputVideoPlayerController
  Stream<bool> get outputIsVideoPlayerControllerInitialized =>
      _videoPlayerControllerStreamController.stream.map((cond) => cond);

  @override
  // TODO: implement inputIsAnyVideoUploaded
  Sink get inputIsAnyVideoUploaded => _isAnyVideoUploadedStreamController.sink;

  @override
  // TODO: implement outputIsAnyVideoUploaded
  Stream<bool> get outputIsAnyVideoUploaded =>
      _isAnyVideoUploadedStreamController.stream.map((cond) => cond);
}

//------------------------------------------------------------------------------inputs and orders
abstract class BusinessVideoViewModelInputs {
  //orders
  Future<void> pickVideo();
  void updateVideoPlayerController();
  void updateVideoEdits(String videoEdits);
  void editVideo();

  //stream inputs
  Sink get inputIsVideoPlayerControllerInitialized;
  Sink get inputIsAnyVideoUploaded;
}

//------------------------------------------------------------------------------outputs
abstract class BusinessVideoViewModelOutputs {
  //stream outputs
  Stream<bool> get outputIsVideoPlayerControllerInitialized;
  Stream<bool> get outputIsAnyVideoUploaded;
}

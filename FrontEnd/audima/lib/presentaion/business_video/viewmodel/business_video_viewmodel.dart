import 'dart:async';
import 'dart:io';

import 'package:audima/domain/usecase/upload_video_usecase.dart';
import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';

class BusinessVideoViewModel extends BaseViewModel
    with BusinessVideoViewModelInputs, BusinessVideoViewModelOutputs {
  late VideoPlayerController controller;
  bool isVideoUploaded=false;
   final UploadVideoUseCase _uploadVideoUseCase;
  BusinessVideoViewModel(this._uploadVideoUseCase);
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
    
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    ).then((result)async{
 if (result != null) {
      if (isVideoUploaded) {
       controller.dispose();
       inputIsVideoPlayerControllerInitialized.add(false);
      }
      isVideoUploaded=true;
      inputState.add(LoadingState(
        stateRendererType: StateRendererType.popUpLoadingState,
        message: "Uploading your Video"));
      File file = File(result.files.single.path!);
      await _uploadVideo(file, "ss");
      controller = VideoPlayerController.file(file)
        ..initialize().then((_) {})
        ..addListener(() {
          updateVideoPlayerController();
        })
        ..play();
      inputState.add(ContentState());
      inputIsAnyVideoUploaded.add(true);
    }
    });
   
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
    videoEditsObject.videoEdits == ""?inputVideoEditsState.add(false):inputVideoEditsState.add(true);
  }

  @override
  void editVideo() {}
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
  Stream<bool> get outputVideoEditsState => _videoEditsStateStreamController.stream.map((cond) => cond);

  //------------------------------------------------------------------------------------------helper functions
  Future<void> _uploadVideo(File video,String caption) async {
 
    (await _uploadVideoUseCase.execute(UploadVideoUseCaseInput(
            video,caption)))
        .fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popUpErrorState, failure.message));

      //left means failure
    }, (data) {
      //right means success
      print("sucess");
      // inputState.add(ContentState());
      // inputMissionStatement.add(data.missionStatement);
      // missionStatementObject = missionStatementObject.copyWith(
      //     missionStatement: data.missionStatement);
    });
  }
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
  Sink get inputVideoEditsState;
}

//------------------------------------------------------------------------------outputs
abstract class BusinessVideoViewModelOutputs {
  //stream outputs
  Stream<bool> get outputIsVideoPlayerControllerInitialized;
  Stream<bool> get outputIsAnyVideoUploaded;
  Stream<bool> get outputVideoEditsState;
}

import 'dart:async';
import 'dart:io';

import 'package:audima/app/app_prefrences.dart';
import 'package:audima/app/di.dart';
import 'package:audima/presentaion/base/baseviewmodel.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:clipboard/clipboard.dart';

class FinalPresentationViewModel extends BaseViewModel
    with FinalPresentationViewModelInputs, FinalPresentationViewModelOutputs {
  //app prefrences for getting the video and mission statement to our final presentation view
  final AppPreferences _appPreferences = instance<AppPreferences>();
  // ---------------------------------------------------------------------------stream controllers
  final StreamController _businessStatementStreamController =
      StreamController<String>.broadcast();
  final StreamController _videoStreamController =
      StreamController<ChewieController>.broadcast();
  // ---------------------------------------------------------------------------initialization phase
  //we will have a chewie player controller to be used in the view, and a mission statement String
  String _missionStatement = "";
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  // ---------------------------------------------------------------------------useful controllers

  @override
  void start() {
    inputState.add(ContentState());
    //add loading state to the stream
    inputState.add(
      LoadingState(
          stateRendererType: StateRendererType.popUpLoadingState,
          message: "Fetching your Business Data"),
    );
    //get the mission statement from the app prefrences
    _appPreferences.getMissionStatement().then(
      (missionStatement) {
        _missionStatement = missionStatement;
        //get the video from the app prefrences
        _appPreferences.getVideoUrl().then(
          (videoUrl) async {
            videoPlayerController = VideoPlayerController.network(videoUrl);
            await Future.wait([videoPlayerController.initialize()]);
            chewieController = ChewieController(
              autoInitialize: true,
              videoPlayerController: videoPlayerController,
              autoPlay: true,
              looping: false,
              aspectRatio: videoPlayerController.value.aspectRatio,
            );
            //now we have the mission statement and the video, give these info to the view
            inputBusinessStatement.add(_missionStatement);
            inputVideo.add(chewieController);
            //now add content state to the stream to render the view
            inputState.add(ContentState());
          },
        );
      },
    );
  }

  @override
  Future<void> saveVideoToGallery() async {
    inputState.add(
      ConfirmationState(
          stateRendererType: StateRendererType.popUpConfirmationState,
          message: "Please confirm saving the video to your gallery",
          listView: SizedBox.shrink(),
          confirmationActionFunction: () async {
            bool permissionGranted = await _requestStoragePermission();
            if (permissionGranted) {
              _appPreferences.getVideoUrl().then((videoUrl) async {
                await _downloadVideo(videoUrl);
              });
            } else {
              // Handle permission denied
            }
          }),
    );
  }

  @override
  Future<void> copyBusinessStatmentToClipboard() async {
    FlutterClipboard.copy(_missionStatement).then(
      (value) => inputState.add(
        SuccessState(StateRendererType.popUpSuccessState,
            "Your mission statement has been copied to your clipboard"),
      ),
    );
  }

//------------------------------------------------------------------------------streams
  @override
  Sink get inputBusinessStatement => _businessStatementStreamController.sink;

  @override
  Sink get inputVideo => _videoStreamController.sink;

  @override
  Stream<String> get outputBusinessStatement =>
      _businessStatementStreamController.stream
          .map((businessStatement) => businessStatement);

  @override
  Stream<ChewieController> get outputVideo =>
      _videoStreamController.stream.map((chewieController) => chewieController);

//helper functions
  Future<bool> _requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> _downloadVideo(String videoUrl) async {
    final file = File(videoUrl);
    //add loading state
    inputState.add(
      LoadingState(
          stateRendererType: StateRendererType.popUpLoadingState,
          message: "Saving your video to gallery"),
    );
    // Save the new file using GallerySaver
    print(file.path);
    await GallerySaver.saveVideo(file.path).then(
      (value) => inputState.add(SuccessState(
          StateRendererType.popUpSuccessState,
          "Your video has been saved successfully")),
    );
  }
}

//------------------------------------------------------------------------------inputs and orders
abstract class FinalPresentationViewModelInputs {
  //orders
  Future<void> saveVideoToGallery();
  Future<void> copyBusinessStatmentToClipboard();
  //stream inputs
  Sink get inputBusinessStatement;
  Sink get inputVideo;
}

//------------------------------------------------------------------------------outputs
abstract class FinalPresentationViewModelOutputs {
  //stream outputs
  Stream<String> get outputBusinessStatement;
  Stream<ChewieController> get outputVideo;
}

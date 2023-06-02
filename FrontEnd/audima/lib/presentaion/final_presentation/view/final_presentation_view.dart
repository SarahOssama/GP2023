import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:audima/app/di.dart';
import 'package:audima/presentaion/base/baseview.dart';
import 'package:audima/presentaion/common/state_renderer/state_renderer_imp.dart';
import 'package:audima/presentaion/final_presentation/viewmodel/final_presentation_viewmodel.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/presentaion/resources/routes_manager.dart';
import 'package:audima/responsive.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FinalPresentationView extends StatefulWidget {
  const FinalPresentationView({super.key});

  @override
  State<FinalPresentationView> createState() => _FinalPresentationViewState();
}

class _FinalPresentationViewState extends State<FinalPresentationView> {
  //view model
  late FinalPresentationViewModel _viewModel;
  //scroll controller
  late ScrollController _mainViewScrollController;
  late ScrollController _missionStatementScrollController;
  //init state
  @override
  void initState() {
    _viewModel = instance<FinalPresentationViewModel>();
    _mainViewScrollController = ScrollController();
    _missionStatementScrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return the video player of the edited video from the app prefereneces and the mission statement
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        snapshot.data == null ? _viewModel.start() : null;
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
    return MainScaffold(
      previousRoute: Routes.businessVideo,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          controller: _mainViewScrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //-------------------------------------------------------------------------------------------
              //business video
              Text(
                "Business Video",
                style:
                    ResponsiveTextStyles.videoAndBusinessDescriptionTextStyle(
                        context),
              ),
              SizedBox(
                height: 10,
              ),
              //video player
              BlackedShadowContainer(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 4,
                child: StreamBuilder<ChewieController>(
                  stream: _viewModel.outputVideo,
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? Chewie(controller: snapshot.data!)
                        : SizedBox.shrink();
                  },
                ),
              ),
              //download button
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  _viewModel.saveVideoToGallery();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  child: Lottie.asset(
                    JsonAssets.download,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //----------------------------------------------------------------------------------------------------------------
              //mission statement
              Text(
                "Mission Statement",
                style:
                    ResponsiveTextStyles.videoAndBusinessDescriptionTextStyle(
                        context),
              ),
              SizedBox(
                height: 10,
              ),
              //mission statement
              BlackedShadowContainer(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 4,
                child: StreamBuilder<String>(
                  stream: _viewModel.outputBusinessStatement,
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? Scrollbar(
                            thumbVisibility: true,
                            controller: _missionStatementScrollController,
                            child: SingleChildScrollView(
                              controller: _missionStatementScrollController,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  snapshot.data!,
                                  textAlign: TextAlign.center,
                                  style: ResponsiveTextStyles
                                      .finalBusinessStatementTextStyle(context),
                                ),
                              ),
                            ),
                          )
                        : SizedBox.shrink();
                  },
                ),
              ),

              SizedBox(
                height: 15,
              ),
              //copy button
              GestureDetector(
                onTap: () {
                  _viewModel.copyBusinessStatmentToClipboard();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  child: Lottie.asset(
                    JsonAssets.copy,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

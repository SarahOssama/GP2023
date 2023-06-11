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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //-------------------------------------------------------------------------------------------
              //business video
              SizedBox(
                height: 15,
              ),
              Text(
                "Business Video",
                style:
                    ResponsiveTextStyles.videoAndBusinessDescriptionTextStyle(
                        context),
              ),
              SizedBox(
                height: 40,
              ),
              //video player
              BlackedShadowContainer(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 2.8,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/audima_bg.jpg"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: StreamBuilder<ChewieController>(
                    stream: _viewModel.outputVideo,
                    builder: (context, snapshot) {
                      return snapshot.data != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Chewie(controller: snapshot.data!),
                            )
                          : SizedBox.shrink();
                    },
                  ),
                ),
              ),
              //download button
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _viewModel.saveVideoToGallery(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
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
              StreamBuilder<List<dynamic>>(
                  stream: _viewModel.outputIsBusinessStatementVisable,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Column(
                            children: [
                              Text(
                                "Mission Statement",
                                style: ResponsiveTextStyles
                                    .videoAndBusinessDescriptionTextStyle(
                                        context),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              //mission statement
                              BlackedShadowContainer(
                                width: MediaQuery.of(context).size.width / 1.3,
                                height: MediaQuery.of(context).size.height / 6,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/audima_bg.jpg"),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: snapshot.data![0] == true
                                      ? Scrollbar(
                                          thumbVisibility: true,
                                          controller:
                                              _missionStatementScrollController,
                                          child: SingleChildScrollView(
                                            controller:
                                                _missionStatementScrollController,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Text(
                                                snapshot.data![1],
                                                textAlign: TextAlign.center,
                                                style: ResponsiveTextStyles
                                                    .finalBusinessStatementTextStyle(
                                                        context),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              //copy button
                              GestureDetector(
                                onTap: () {
                                  _viewModel.copyBusinessStatmentToClipboard();
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Lottie.asset(
                                    JsonAssets.copy,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox.shrink();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

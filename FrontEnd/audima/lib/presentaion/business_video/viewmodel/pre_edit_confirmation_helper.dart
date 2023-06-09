import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:colornames/colornames.dart';

class ActiobEditMenuItems extends StatelessWidget {
  double videoDuration;
  int index;
  Map<String, dynamic> features;
  List<String>? listOfAvailableColors;
  List<String>? listOfAvailableSizes;
  List<String>? listOfAvailablePositions;
  ActiobEditMenuItems({
    required this.videoDuration,
    required this.index,
    required this.features,
    this.listOfAvailableColors,
    this.listOfAvailableSizes,
    this.listOfAvailablePositions,
  });

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem> items = [];
    return Column(
      children: [
        if (features.entries.elementAt(index).key == "startTime")
          for (double i = 0.0;
              i < features["endTime"];
              i += 0.1) // Replace with the actual number of items

            PopupMenuItem(
              value: i,
              child: Text(i.toStringAsFixed(1)),
            ),
        if (features.entries.elementAt(index).key == "endTime")
          for (double i = features["startTime"] + 0.1;
              i < videoDuration;
              i += 0.1) // Replace with the actual number of items
            PopupMenuItem(
              value: i,
              child: Text(i.toStringAsFixed(1)),
            ),
        if (features.entries.elementAt(index).key == "factor")
          for (double i = 1;
              i < videoDuration;
              i += 0.1) // Replace with the actual number of items
            PopupMenuItem(
              value: i,
              child: Text(i.toStringAsFixed(1)),
            ),
        //these other features are not time related which will be found but not in every action
        if (features.entries.elementAt(index).key == "color")
          ColorPicker(
            pickerColor: Color(0xff443a49),
            onColorChanged: (Color color) {},
            pickerAreaHeightPercent: 0.8,
          ),
        if (features.entries.elementAt(index).key == "fontSize")
          for (String i
              in listOfAvailableSizes!) // Replace with the actual number of items
            PopupMenuItem(
              value: i,
              child: Text(i),
            ),
        if (features.entries.elementAt(index).key == "textPosition")
          for (String i
              in listOfAvailablePositions!) // Replace with the actual number of items
            PopupMenuItem(
              value: i,
              child: Text(i),
            ),
      ],
    );
  }
}

class FeatureTrailing extends StatelessWidget {
  String action;
  String featureKey;
  Map<String, dynamic> features;
  double videoDuration;
  int objectIndex;
  TextEditingController editUserTextController;
  List<String>? listOfAvailableColors;
  List<String>? listOfAvailableSizes;
  List<String>? listOfAvailablePositions;
  VoidCallback onFteaureChanged;
  FeatureTrailing({
    required this.action,
    required this.featureKey,
    required this.features,
    required this.videoDuration,
    required this.objectIndex,
    required this.editUserTextController,
    this.listOfAvailableColors,
    this.listOfAvailableSizes,
    this.listOfAvailablePositions,
    required this.onFteaureChanged,
  });

  @override
  Widget build(BuildContext context) {
    //case add text feature->remove the lists from the data.features
    ScrollController preEditInnerMenuScrollController = ScrollController();
    if (featureKey == "text") {
      return SizedBox.shrink();
    } else if (featureKey == "color") {
      String hexaColor = "";
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Pick a color!'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    enableAlpha: false,
                    labelTypes: [],
                    pickerColor: Color(0xff443a49),
                    onColorChanged: (Color color) {
                      hexaColor = color.value.toRadixString(16);
                      hexaColor = "#" + hexaColor.substring(2);
                      features[features.entries.elementAt(objectIndex).key] =
                          hexaColor;
                      onFteaureChanged.call();
                      // _isFeatureChangedStreamController.add(true);
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Confirm'),
                    onPressed: () {
                      features[features.entries.elementAt(objectIndex).key] =
                          hexaColor;
                      onFteaureChanged.call();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: 30,
          height: 30,
          child: Lottie.asset(
            JsonAssets.edit,
          ),
        ),
      );
    } else {
      return DropdownButtonHideUnderline(
        child: PopupMenuButton(
          padding: EdgeInsets.zero,
          icon: null,
          iconSize: 0,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                padding: EdgeInsets.zero,
                child: Container(
                  height: 130, // Set the desired height for the menu
                  child: Column(
                    children: [
                      Expanded(
                        child: Scrollbar(
                          controller: preEditInnerMenuScrollController,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: preEditInnerMenuScrollController,
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                action == "Add Text"
                                    ? ActiobEditMenuItems(
                                        videoDuration: videoDuration,
                                        index: objectIndex,
                                        features: features,
                                        listOfAvailableColors:
                                            listOfAvailableColors,
                                        listOfAvailableSizes:
                                            listOfAvailableSizes,
                                        listOfAvailablePositions:
                                            listOfAvailablePositions,
                                      )
                                    : ActiobEditMenuItems(
                                        videoDuration: videoDuration,
                                        index: objectIndex,
                                        features: features)
                              ],
                            ),
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
            features[features.entries.elementAt(objectIndex).key] = value;
            onFteaureChanged.call();
            // _isFeatureChangedStreamController.add(true);
          },
        ),
      );
    }
  }
}

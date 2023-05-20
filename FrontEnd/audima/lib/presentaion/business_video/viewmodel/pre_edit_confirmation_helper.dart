import 'package:flutter/material.dart';

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
          for (double i = 0.0;
              i < videoDuration;
              i += 0.1) // Replace with the actual number of items
            PopupMenuItem(
              value: i,
              child: Text(i.toStringAsFixed(1)),
            ),
        //these other features are not time related which will be found but not in every action
        if (features.entries.elementAt(index).key == "color")
          for (String i
              in listOfAvailableColors!) // Replace with the actual number of items
            PopupMenuItem(
              value: i.toString(),
              child: Text(i),
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

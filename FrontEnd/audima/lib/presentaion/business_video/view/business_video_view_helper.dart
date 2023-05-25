import 'package:flutter/material.dart';

class ExpandableTextField extends StatefulWidget {
  TextEditingController textEditingController = TextEditingController();
  ExpandableTextField({required this.textEditingController});

  @override
  _ExpandableTextFieldState createState() => _ExpandableTextFieldState();
}

class _ExpandableTextFieldState extends State<ExpandableTextField> {
  double _textFieldHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return TextField(
          controller: widget.textEditingController,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: null,
          onChanged: (text) {
            final textPainter = TextPainter(
              text: TextSpan(text: text, style: TextStyle(fontSize: 16.0)),
              maxLines: null,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(maxWidth: constraints.maxWidth);

            setState(() {
              _textFieldHeight =
                  textPainter.size.height + 20.0; // Add extra padding
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Type in your video edits',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        );
      },
    );
    ;
  }

  @override
  void dispose() {
    widget.textEditingController.dispose();
    super.dispose();
  }
}

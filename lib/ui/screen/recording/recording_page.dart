import 'package:flutter/material.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/text_styles.dart';

class RecordingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecordingState();
}

class RecordingState extends State<RecordingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Text('ShowPage', style: TextStylesUtils().styleMedium20TextSelect),
          )
        ],
      ),
    );
  }

}

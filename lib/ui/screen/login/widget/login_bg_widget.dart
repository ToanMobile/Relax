import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';

class BackgroundLogin extends StatelessWidget {
  final String bgBackgroud;

  BackgroundLogin({@required this.bgBackgroud});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.screenWidthDp,
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        bgBackgroud,
        width: ScreenUtil.screenWidthDp,
        fit: BoxFit.fill,
      ),
    );
  }
}

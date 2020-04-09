import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/res/image.dart';

class BackgroundLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.screenWidthDp,
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        ImagesUtils.bgLogin,
        width: ScreenUtil.screenWidthDp,
        fit: BoxFit.fill,
      ),
    );
  }
}

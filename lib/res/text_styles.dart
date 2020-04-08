import 'dart:ui';

import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/lib/screenutils/screenutil.dart';
import 'package:relax/res/colors.dart';
import 'package:flutter/material.dart';

class TextStylesUtils {
  static const FontFamilyRegular = 'Roboto';
  static const FontFamilyLight = 'RobotoLight';
  static const fontFamilyMedium = "RobotoMedium";

  final styleMedium18Black = TextStyle(
    fontFamily: fontFamilyMedium,
    color: ColorsUtils.black,
    fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
    fontStyle: FontStyle.normal,
  );

  final styleMedium18White = TextStyle(
    fontFamily: fontFamilyMedium,
    color: ColorsUtils.white,
    fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
    fontStyle: FontStyle.normal,
  );

  final styleMedium20Black = TextStyle(
    fontFamily: fontFamilyMedium,
    color: ColorsUtils.black,
    fontSize: ScreenUtil().setSp(20, allowFontScalingSelf: true),
    fontStyle: FontStyle.normal,
  );

  final styleMedium20TextSelect = TextStyle(
    fontFamily: fontFamilyMedium,
    color: ColorsUtils.textSelect,
    fontSize: ScreenUtil().setSp(20, allowFontScalingSelf: true),
    fontStyle: FontStyle.normal,
  );

  final styleMedium20White = TextStyle(
    fontFamily: fontFamilyMedium,
    color: ColorsUtils.white,
    fontSize: ScreenUtil().setSp(20, allowFontScalingSelf: true),
    fontStyle: FontStyle.normal,
  );

  final styleRegular20TextSelect = TextStyle(
    fontFamily: FontFamilyRegular,
    color: ColorsUtils.textSelect,
    fontSize: ScreenUtil().setSp(20, allowFontScalingSelf: true),
    fontStyle: FontStyle.normal,
  );

  final styleMedium30White = TextStyle(
    fontFamily: fontFamilyMedium,
    color: ColorsUtils.white,
    fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
    fontStyle: FontStyle.normal,
  );
}

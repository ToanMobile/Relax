import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:relax/res/colors.dart';

class TextStylesUtils {
  static const FontFamilyRegular = 'Roboto';
  static const FontFamilyLight = 'RobotoLight';
  static const fontFamilyMedium = "RobotoMedium";

  static const styleRegular12BrownGreyW400 = const TextStyle(
    //fontFamily: FontFamilyRegular,
    color: ColorsUtils.brownGrey,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  static const styleRegular12WhiteW400 = const TextStyle(
    //fontFamily: FontFamilyRegular,
    color: ColorsUtils.white,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  static const styleRegular12PinkishOrangeW600 = const TextStyle(
    //fontFamily: FontFamilyRegular,
    color: ColorsUtils.pinkishOrange,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.21428574,
  );

  static const styleRegular14BlackW400 = const TextStyle(
    //fontFamily: FontFamilyRegular,
    color: ColorsUtils.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  static const styleRegular14WhiteW600 = const TextStyle(
    //fontFamily: FontFamilyRegular,
    color: ColorsUtils.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  static const styleMedium18Black = const TextStyle(
    //fontFamily: fontFamilyMedium,
    color: ColorsUtils.black,
    fontSize: 18,
    fontStyle: FontStyle.normal,
  );

  static const styleMedium18White = const TextStyle(
    //fontFamily: fontFamilyMedium,
    color: ColorsUtils.white,
    fontSize: 18,
    fontStyle: FontStyle.normal,
  );

  static const styleMedium20Black = const TextStyle(
    //fontFamily: fontFamilyMedium,
    color: ColorsUtils.black,
    fontSize: 20,
    fontStyle: FontStyle.normal,
  );

  static const styleMedium20CoalGreyW600 = const TextStyle(color: ColorsUtils.charcoalGrey, fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal);

  static const styleMedium20TextSelect = const TextStyle(
    //fontFamily: fontFamilyMedium,
    color: ColorsUtils.textSelect,
    fontSize: 20,
    fontStyle: FontStyle.normal,
  );

  static const styleMedium20White = const TextStyle(
    //fontFamily: fontFamilyMedium,
    color: ColorsUtils.white,
    fontSize: 20,
    fontStyle: FontStyle.normal,
  );

  static const styleMedium20WhiteW600 = const TextStyle(
    //fontFamily: fontFamilyMedium,
    color: ColorsUtils.white,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  static const styleRegular20TextSelect = const TextStyle(
    //fontFamily: FontFamilyRegular,
    color: ColorsUtils.textSelect,
    fontSize: 20,
    fontStyle: FontStyle.normal,
  );

  static const styleRegular20CoalGreyW600 = const TextStyle(
    //fontFamily: FontFamilyRegular,
    color: ColorsUtils.charcoalGrey,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  static const styleMedium30White = const TextStyle(
    //fontFamily: fontFamilyMedium,
    color: ColorsUtils.white,
    fontSize: 30,
    fontStyle: FontStyle.normal,
  );
}

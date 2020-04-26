import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:relax/res/colors.dart';

class Constant {
  static const bool inProduction = const bool.fromEnvironment("dart.vm.product");

  static bool isTest = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const String key_guide = 'key_guide';
  static const String phone = 'phone';
  static const String access_Token = 'accessToken';
  static const String refresh_Token = 'refreshToken';

  static const String theme = "AppTheme";
  static int check_code = 123456;
  static DateFormat format = DateFormat("yyyy-MM-dd HH:mm");
  static const gradient_WaterMelon_Melon = LinearGradient(colors: [ColorsUtils.watermelon, ColorsUtils.melon]);
  static const List<Color> colorListMelonWaterMelon = [ColorsUtils.watermelon, ColorsUtils.melon];
}

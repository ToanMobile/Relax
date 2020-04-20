import 'dart:convert';

import 'package:relax/utils/log_utils.dart';
import 'package:relax/viewmodel/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static SharedPreferences sharedPreferences;

  Future init() async {
    Log.init();
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool isLogin = sharedPreferences.getBool(LoginModel.preIsLogin) ?? false;

  static dynamic getObject(String key) {
    if (sharedPreferences.getString(key) != null) {
      return jsonDecode(sharedPreferences.getString(key));
    }
  }

  static void saveObject(String key, dynamic value) {
    sharedPreferences.setString(key, jsonEncode(value));
  }
}

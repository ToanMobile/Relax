import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:relax/utils/log_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static SharedPreferences sharedPreferences;
  static LocalStorage localStorage;
  static const String preLoginUser = 'preLoginUser';

  Future init() async {
    Log.init();
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready;
  }

  static dynamic getObject(String key) {
    return jsonDecode(sharedPreferences.getString(key));
  }

  static void saveObject(String key, dynamic value) {
    sharedPreferences.setString(key, jsonEncode(value));
  }
}

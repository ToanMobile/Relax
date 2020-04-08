import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:relax/utils/log_utils.dart';

class StorageManager {
  static SharedPreferences sharedPreferences;
  static LocalStorage localStorage;
  static const String preLoginUser = 'preLoginUser';
  static const String preToken = 'preToken';

  Future init() async {
    Log.init();
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready;
  }

  static dynamic getObject(String key) {
    return sharedPreferences.getString(key);
  }

  static void saveObject(String key, dynamic value) {
    sharedPreferences.setString(key, jsonEncode(value));
  }
}

import 'package:flutter/material.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/generated/l10n.dart';

class LocaleModel extends ChangeNotifier {
  static const localeValueList = ['vi', 'en'];
  static const kLocaleIndex = 'kLocaleIndex';

  int _localeIndex;

  int get localeIndex => _localeIndex;

  Locale get locale {
    _localeIndex = 0;
    var value = localeValueList[_localeIndex].split("-");
    return Locale(value[0], value.length == 2 ? value[1] : '');
  }

  LocaleModel() {
    _localeIndex = StorageManager.sharedPreferences?.getInt(kLocaleIndex) ?? 0;
    switchLocale(0);
  }

  switchLocale(int index) {
    _localeIndex = index;
    notifyListeners();
    StorageManager.sharedPreferences?.setInt(kLocaleIndex, index);
  }

  static String localeName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).autoBySystem;
      case 1:
        return 'Việt Nam';
      case 2:
        return 'English';
      case 3:
        return 'Đức';
      default:
        return '';
    }
  }
}

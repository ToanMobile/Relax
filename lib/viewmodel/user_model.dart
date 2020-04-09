import 'package:flutter/cupertino.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';

class UserModel extends ChangeNotifier {
  LoginEntity _loginEntity;

  LoginEntity get login => _loginEntity;

  bool get hasLogin => login != null;

  String get getName => login != null ? login.name : "";

  UserModel() {
    _loginEntity = JsonConvert.fromJsonAsT(StorageManager.getObject(StorageManager.preLoginUser));
  }

  saveUser(LoginEntity loginEntity) {
    _loginEntity = loginEntity;
    notifyListeners();
    StorageManager.localStorage.setItem(StorageManager.preLoginUser, loginEntity);
  }

  clearUser() {
    _loginEntity = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(StorageManager.preLoginUser);
  }
}

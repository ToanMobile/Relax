import 'package:flutter/cupertino.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/service/base_entity.dart';

class UserModel extends ChangeNotifier {
  static const String kUser = 'PrefLogin';

  LoginEntity _loginEntity;

  LoginEntity get login => _loginEntity;

  bool get hasLogin => login != null;

  UserModel() {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _loginEntity = userMap != null ? BaseEntity.fromJson(userMap) as LoginEntity : null;
  }

  saveUser(LoginEntity loginEntity) {
    _loginEntity = loginEntity;
    notifyListeners();
    StorageManager.localStorage.setItem(kUser, loginEntity);
  }

  clearUser() {
    _loginEntity = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(kUser);
  }
}

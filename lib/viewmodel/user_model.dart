import 'package:flutter/cupertino.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/repository/login_repository.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';

import 'login_model.dart';

class UserModel extends ChangeNotifier {
  LoginEntity _loginEntity;

  String get getName =>  _loginEntity != null ? _loginEntity.name :"";

  UserModel() {
    _loginEntity = JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preLoginUser));
  }

  List<LoginEntity> get listUser => LoginRepository.listUser() ?? null;

  saveUser(LoginEntity loginEntity) {
    _loginEntity = loginEntity;
    notifyListeners();
    StorageManager.saveObject(LoginModel.preLoginUser, loginEntity);
  }

  clearUser() {
    _loginEntity = null;
    notifyListeners();
    StorageManager.saveObject(LoginModel.preLoginUser, null);
  }
}

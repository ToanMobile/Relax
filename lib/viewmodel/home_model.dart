import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/repository/home_repository.dart';
import 'package:relax/data/repository/login_register_repository.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';
import 'package:relax/provider/view_state_model.dart';

import 'login_model.dart';

class HomeModel extends ViewStateModel {
  LoginEntity _loginEntity;

  String get getName => _loginEntity != null ? _loginEntity.name : "";

  HomeModel() {
    _loginEntity = JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preLoginUser));
  }

  List<LoginEntity> get listUser => LoginRegisterRepository.listUser() ?? null;

  Future<DataLogin> checkRegisterDriver() async {
    try {
      return await LoginRegisterRepository.checkRegisterDriver(_loginEntity.uid, true);
    } catch (e, s) {
      return DataLogin.ERROR;
    }
  }

  Future<bool> getListOffer() async {
    setBusy();
    try {
      await HomeRepository.getOffer();
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  saveUser(LoginEntity loginEntity) {
    _loginEntity = loginEntity;
    StorageManager.saveObject(LoginModel.preLoginUser, loginEntity);
    setIdle();
  }

  clearUser() {
    _loginEntity = null;
    StorageManager.saveObject(LoginModel.preLoginUser, null);
    setIdle();
  }

  Future<bool> logout() async {
    setBusy();
    try {
      await LoginRegisterRepository.logout();
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}

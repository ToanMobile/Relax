import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/driver_offer_entity.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/repository/home_repository.dart';
import 'package:relax/data/repository/login_register_repository.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';
import 'package:relax/provider/view_state_model.dart';

import 'login_model.dart';

class HomeModel extends ViewStateModel {
  LoginEntity _loginEntity;
  List<DriverOfferEntity> listOffer;

  String get getName => _loginEntity != null ? _loginEntity.name : "";

  HomeModel() {
    _loginEntity = JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preLoginUser));
  }

  Future<DataLogin> checkRegisterDriver() async {
    try {
      return await LoginRegisterRepository.checkRegisterDriver(_loginEntity.uid, true);
    } catch (e, s) {
      return DataLogin.ERROR;
    }
  }

  Future getListOffer() async {
    setBusy();
    try {
      listOffer = await HomeRepository.getListOffer();
      setIdle();
      return;
    } catch (e, s) {
      setError(e, s);
      return;
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

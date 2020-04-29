import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/model/offer_info_entity.dart';
import 'package:relax/data/repository/home_repository.dart';
import 'package:relax/data/repository/login_register_repository.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';
import 'package:relax/provider/view_state_model.dart';

import 'login_model.dart';

enum ROLE { CAPTURE, DRIVER, SHIPPER, DRIVER_SHIPPER, ERROR }

class HomeModel extends ViewStateModel {
  LoginEntity _loginEntity;
  List<OfferInfoEntity> listOffer;
  ROLE roleCheck;

  String get getName => _loginEntity != null ? _loginEntity.name : "";

  int get getRole => _loginEntity != null ? _loginEntity.role : 0;

  LoginEntity get user => _loginEntity != null ? _loginEntity : null;

  HomeModel() {
    _loginEntity = JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preLoginUser));
  }

  Future checkRegisterDriver() async {
    try {
      setBusy();
      roleCheck = await LoginRegisterRepository.checkRegisterDriver(_loginEntity.uid, getRole);
    } catch (e, s) {
      return;
    }
  }

  Future getListOffer() async {
    try {
      listOffer = await HomeRepository.getListOffer(getRole);
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

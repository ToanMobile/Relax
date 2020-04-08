import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/model/register_entity.dart';
import 'package:relax/data/repository/repository.dart';
import 'package:relax/data/service/base_entity.dart';
import 'package:relax/provider/view_state_model.dart';

class LoginModel extends ViewStateModel {

  LoginEntity getLogin() => BaseEntity.fromJson(StorageManager.getObject(StorageManager.preLoginUser)) as LoginEntity;

  Future<bool> login(loginName, password) async {
    setBusy();
    try {
      var user = await Repository.login(loginName, password);
      StorageManager.saveObject(StorageManager.preLoginUser, user);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<bool> register(loginName, email, password) async {
    setBusy();
    try {
      var user = await Repository.register(loginName, email, password);
      StorageManager.sharedPreferences.setString(StorageManager.preToken, (user as RegisterEntity).jwt);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<bool> logout() async {
    setBusy();
    try {
      await Repository.logout();
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}

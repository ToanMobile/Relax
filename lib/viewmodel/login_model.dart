import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/repository/login_repository.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';
import 'package:relax/provider/view_state_model.dart';

enum DataLogin { HOME, CAPTURE, MAP, ERROR }

class LoginModel extends ViewStateModel {
  static const String preLoginUser = 'preLoginUser';
  static const String preListUser = 'preListUser';
  static const String preIsLogin = 'preIsLogin';
  static const String preEmail = 'preEmail';

  LoginEntity getLogin() => JsonConvert.fromJsonAsT(StorageManager.getObject(preLoginUser));

  Future<DataLogin> login(String email,String password) async {
    setBusy();
    print('login=' + email);
    try {
      DataLogin data = await LoginRepository.login(email.trim(), password.trim());
      setIdle();
      return data;
    } catch (e, s) {
      setError(e, s);
      return DataLogin.ERROR;
    }
  }

  Future<bool> register(loginName, email, password) async {
    setBusy();
    try {
      await LoginRepository.register(loginName, email, password);
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
      await LoginRepository.logout();
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}

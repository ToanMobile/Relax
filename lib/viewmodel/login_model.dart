import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/repository/login_register_repository.dart';
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
      DataLogin data = await LoginRegisterRepository.login(email.trim(), password.trim());
      setIdle();
      return data;
    } catch (e, s) {
      setError(e, s);
      return DataLogin.ERROR;
    }
  }
}

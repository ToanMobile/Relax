import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/repository/login_register_repository.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';
import 'package:relax/provider/view_state_model.dart';

class LoginModel extends ViewStateModel {
  static const String preLoginUser = 'preLoginUser';
  static const String preIsLogin = 'preIsLogin';

  LoginEntity getLogin() => JsonConvert.fromJsonAsT(StorageManager.getObject(preLoginUser));

  Future<bool> login(String email, String password) async {
    setBusy();
    print('login=' + email);
    try {
      await LoginRegisterRepository.login(email.trim(), password.trim());
      setIdle();
      return true;
    } catch (e, s) {
      print('error=' + s.toString());
      setError(e, s);
      return false;
    }
  }
}

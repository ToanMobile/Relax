
import 'package:relax/data/repository/login_register_repository.dart';
import 'package:relax/provider/view_state_model.dart';

class RegisterModel extends ViewStateModel {

  Future<bool> register(loginName, email, password, address, phone, role) async {
    setBusy();
    try {
      await LoginRegisterRepository.register(loginName, email, password, address, phone, role);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

}

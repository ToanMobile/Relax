import 'package:firebase_auth/firebase_auth.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/model/register_entity.dart';
import 'package:relax/data/service/dio_utils.dart';
import 'package:relax/data/service/http_api.dart';

import 'base_repository.dart';

class LoginRepository {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static LoginEntity userFromFirebaseUser(user) {
    return user != null ?  LoginEntity(uid :user.uid) : null;
  }

  static Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future logout() async {
    return DioUtils.instance.asyncRequestNetwork<RegisterEntity>(Method.post, HttpApi.login,
        onSuccess: (data) {
          if (data != null) {
            printLog(data);
          }
        },
        onSuccessList: (data) {
          if (data != null) {
            printLog(data);
          }
        },
        onError: (code, msg) {
          printLog("$msg code=$code");
        }
    );
  }

  static Future register(String username, String email, String password) async {
    Map<String, String> params = Map();
    params["username"] = username;
    params["email"] = email;
    params["password"] = password;

    return DioUtils.instance.asyncRequestNetwork<RegisterEntity>(Method.post, HttpApi.register,
        params: params,
        onSuccess: (data) {
          if (data != null) {
            printLog(data);
          }
        },
        onSuccessList: (data) {
          if (data != null) {
            printLog(data);
          }
        },
        onError: (code, msg) {
          printLog("$msg code=$code");
        }
    );
  }
  
  static void printLog(dynamic data){
    BaseRepository.logger.e(data);
  }
}

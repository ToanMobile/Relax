import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/viewmodel/home_model.dart';
import 'package:relax/viewmodel/login_model.dart';
import 'base_repository.dart';

class LoginRegisterRepository {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final CollectionReference infoCollection = Firestore.instance.collection('firstInfos');
  static final CollectionReference driverCollection = Firestore.instance.collection('driverInfos');

  // static List<LoginEntity> listUser() => JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preListUser));
  static Future login(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user ?? null;
    await infoCollection.document(user.uid).get().then((value) {
      saveUser(user.uid, email, value.data, true);
    });
  }

  static Future<DataLogin> checkRegisterDriver(String uid, int role) async {
    DataLogin data;
    await driverCollection.document(uid).get().then(
      (value) {
        if (value.data != null && value.data['driver_status'] == "0") {
          if (role == Constant.role_shipper) {
            data = DataLogin.SHIPPER;
          } else if (role == Constant.role_driver) {
            data = DataLogin.DRIVER;
          } else if (role == Constant.role_shipper_driver) {
            data = DataLogin.DRIVER_SHIPPER;
          }
        } else {
          data = DataLogin.CAPTURE;
        }
      },
    );
    printLog('checkRegisterDriver:'+data.toString());
    return data;
  }

  static Future register(String name, String email, String password, String address, String phone, int role) async {
    AuthResult result;
    try {
      result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, s) {
      printLog(e.toString());
    }
    LoginEntity loginEntity = LoginEntity();
    loginEntity.name = name;
    loginEntity.email = email;
    loginEntity.address = address;
    loginEntity.role = role;
    loginEntity.tel = phone;
    printLog('register:loginEntity=' + loginEntity.toString());
    if (result == null) {
      result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      loginEntity.uid = user.uid;
      await infoCollection.document(user.uid).setData(loginEntity.toJson());
    } else {
      //case đã tồn tại user này
      await infoCollection.document(result.user.uid).updateData(loginEntity.toJson());
    }
    StorageManager.sharedPreferences.setBool(LoginModel.preIsLogin, true);
    StorageManager.saveObject(LoginModel.preLoginUser, loginEntity);
  }

  static saveUser(String uid, String email, Map<String, dynamic> snapshot, bool isSave) {
    printLog(snapshot);
    LoginEntity loginEntity = LoginEntity();
    loginEntity.uid = uid;
    loginEntity.email = email;
    loginEntity.address = snapshot['address'];
    loginEntity.name = snapshot['name'];
    loginEntity.role = snapshot['role'];
    loginEntity.tel = snapshot['tel'];
    if (isSave) {
      StorageManager.sharedPreferences.setBool(LoginModel.preIsLogin, true);
      StorageManager.saveObject(LoginModel.preLoginUser, loginEntity);
    }
    //printLog('saveUser=$loginEntity');
    return loginEntity;
  }

  static Future logout() async {
    await StorageManager.sharedPreferences.clear();
    await _auth.signOut();
  }

  static void printLog(dynamic data) {
    BaseRepository.logger.e(data);
  }
}

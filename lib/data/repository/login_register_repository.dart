import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/viewmodel/login_model.dart';

import 'base_repository.dart';

class LoginRegisterRepository {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final CollectionReference infoCollection = Firestore.instance.collection('firstInfos');
  static final CollectionReference driverCollection = Firestore.instance.collection('driverInfos');
  // static List<LoginEntity> listUser() => JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preListUser));
  static Future<DataLogin> login(String email, String password) async {
    DataLogin data;
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user ?? null;
    await infoCollection.document(user.uid).get().then((value) {
      saveUser(user.uid, value.data, true);
    });
    data = await checkRegisterDriver(user.uid, false);
    StorageManager.sharedPreferences.setString(LoginModel.preEmail, email);
    return data;
  }

  static Future<DataLogin> checkRegisterDriver(String uid, bool isHome) async {
    DataLogin data;
    await driverCollection.document(uid).get().then(
      (value) {
        if (isHome) {
          if (value.data != null && value.data['driver_status'] == "0") {
            printLog('MAP');
            data = DataLogin.MAP;
          } else {
            printLog('CAPTURE');
            data = DataLogin.CAPTURE;
          }
        } else {
          if (value.data != null && value.data['driver_status'] == "0") {
            printLog('MAP');
            data = DataLogin.MAP;
          } else {
            printLog('HOME');
            data = DataLogin.HOME;
          }
        }
      },
    );
    return data;
  }

  static Future register(String name, String email, String password, String address, String phone, int role) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user ?? null;
    printLog('register:user=' + user.email);
    LoginEntity loginEntity = LoginEntity();
    loginEntity.uid = user.uid;
    loginEntity.name = name;
    loginEntity.email = email;
    loginEntity.address = address;
    loginEntity.role = role;
    loginEntity.tel = phone;
    printLog('register:loginEntity=' + loginEntity.toString());
    if (user == null) {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      user = result.user;
      await infoCollection.document(user.uid).setData(loginEntity.toJson());
    } else {
      //case đã tồn tại user này
      await infoCollection.document(user.uid).updateData(loginEntity.toJson());
    }
    StorageManager.sharedPreferences.setBool(LoginModel.preIsLogin, true);
    StorageManager.saveObject(LoginModel.preLoginUser, loginEntity);
    StorageManager.sharedPreferences.setString(LoginModel.preEmail, email);
  }

  static saveUser(String uid, Map<String, dynamic> snapshot, bool isSave) {
    printLog(snapshot);
    LoginEntity loginEntity = LoginEntity();
    loginEntity.uid = uid;
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';
import 'package:relax/viewmodel/login_model.dart';

import 'base_repository.dart';

class LoginRepository {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final CollectionReference infoCollection = Firestore.instance.collection('firstInfos');
  static final CollectionReference driverCollection = Firestore.instance.collection('driverInfos');

  static List<LoginEntity> listUser() => JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preListUser));

  static Future<DataLogin> login(String email, String password) async {
    DataLogin data;
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    await driverCollection.document(user.uid).get().then((value) {
      printLog(value.data['status']);

    });
    await infoCollection.document(user.uid).get().then((value) {
      saveUser(user.uid, value.data, true);
    });
    List<LoginEntity> list = List();
    await infoCollection.getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach(
        (doc) => {list.add(saveUser(doc.data['uid'] ?? "", doc.data, false))},
      );
    });
    StorageManager.sharedPreferences.setString(LoginModel.preEmail, email);
    StorageManager.saveObject(LoginModel.preListUser, list);
    return data;
  }

  static Future<DataLogin> checkRegisterDriver(String uid) async {
    DataLogin data;
    await driverCollection.document(uid).get().then(
      (value) {
        printLog(value.data['status']);
        if (value.data['status'] != null) {
          printLog('MAP');
          data = DataLogin.MAP;
        } else {
          printLog('CAPTURE');
          data = DataLogin.CAPTURE;
        }
      },
    );
    return data;
  }

  static Future register(String email, String password, FirebaseUser firebaseUser) async {
    FirebaseUser user = firebaseUser;
    if (user == null) {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      user = result.user;
    }
    await infoCollection.document(user.uid).get().then((value) {
      saveUser(user.uid, value.data, true);
    });
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

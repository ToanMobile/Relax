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

  static List<LoginEntity> listUser() {
    return JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preListUser)) ?? List();
  }

  static Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await infoCollection.document(user.uid).get().then((value) {
        saveUser(user.uid, value.data, true);
      });
      List<LoginEntity> list = List();
      await infoCollection.getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach(
          (doc) => {list.add(saveUser(doc.data['uid'] ?? "", doc.data, false))},
        );
      });
      StorageManager.saveObject(LoginModel.preListUser, list);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future register(String email, String password, FirebaseUser firebaseUser) async {
    try {
      FirebaseUser user = firebaseUser;
      if (user == null) {
        AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        user = result.user;
      }
      await infoCollection.document(user.uid).get().then((value) {
        saveUser(user.uid, value.data, true);
        return true;
      });
    } catch (e) {
      printLog(e);
      return false;
    }
  }

  static saveUser(String uid, Map<String, dynamic> snapshot, bool isSave) {
    LoginEntity loginEntity = LoginEntity(
      uid: uid,
      address: snapshot['address'],
      name: snapshot['name'],
      role: snapshot['role'],
      tel: snapshot['tel'],
    );
    if (isSave) {
      StorageManager.sharedPreferences.setBool(LoginModel.preIsLogin, true);
      StorageManager.saveObject(LoginModel.preLoginUser, loginEntity);
    }
    printLog('saveUser=$loginEntity');
    return loginEntity;
  }

  static Future logout() async {
    try {
      await StorageManager.sharedPreferences.clear();
      await _auth.signOut();
      return true;
    } catch (e) {
      printLog(e);
      return false;
    }
  }

  static void printLog(dynamic data) {
    BaseRepository.logger.e(data);
  }
}

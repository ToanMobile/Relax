import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/service/dio_utils.dart';
import 'package:relax/data/service/http_api.dart';
import 'package:relax/viewmodel/login_model.dart';
import 'base_repository.dart';

class HomeRepository {
  static final CollectionReference infoCollection = Firestore.instance.collection('firstInfos');

  static Future getListHome() async {
    return DioUtils.instance.asyncRequestNetwork<LoginEntity>(Method.post, HttpApi.login,
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

  static Future getOffer() async {
    List<LoginEntity> list = List();
    await infoCollection.getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach(
            (doc) => {
          list.add(saveUser(doc.data['uid'] ?? "", doc.data, false)),
        },
      );
    });
    StorageManager.saveObject(LoginModel.preListUser, list);
    return list;
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

  static void printLog(dynamic data){
    BaseRepository.logger.e(data);
  }
}

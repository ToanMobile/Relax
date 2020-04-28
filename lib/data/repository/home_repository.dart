import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/model/offer_info_entity.dart';
import 'package:relax/data/service/dio_utils.dart';
import 'package:relax/data/service/http_api.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';
import 'package:relax/viewmodel/login_model.dart';
import 'base_repository.dart';

class HomeRepository {
  static final CollectionReference driverOfferCollection = Firestore.instance.collection('driverOffer');
  static final CollectionReference shipperCollection = Firestore.instance.collection('requestPool');

  static Future getListHome() async {
    return DioUtils.instance.asyncRequestNetwork<LoginEntity>(Method.post, HttpApi.login, onSuccess: (data) {
      if (data != null) {
        printLog(data);
      }
    }, onSuccessList: (data) {
      if (data != null) {
        printLog(data);
      }
    }, onError: (code, msg) {
      printLog("$msg code=$code");
    });
  }

  static Future<List<OfferInfoEntity>> getListOffer(int role) async {
    List<OfferInfoEntity> list = List();
    LoginEntity user = JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preLoginUser));
    printLog(user.toString());
    if (role == Constant.role_shipper) {
      await shipperCollection.getDocuments().then((value) {
        value.documents.forEach((e) {
          if (e.data != null && e.data['customer_id'] == user.customer_id) {
            printLog(e.data.toString());
            list.add(OfferInfoEntity().fromJson(e.data));
          }
        });
      });
    } else if (role == Constant.role_driver) {
      await driverOfferCollection.getDocuments().then((value) {
        value.documents.forEach((e) {
          if (e.data != null && e.data['customer_id'] == user.customer_id) {
            printLog(e.data.toString());
            list.add(OfferInfoEntity().fromJson(e.data));
          }
        });
      });
    } else if (role == Constant.role_shipper_driver) {
      await shipperCollection.getDocuments().then((value) {
        value.documents.forEach((e) {
          if (e.data != null && e.data['customer_id'] == user.customer_id) {
            printLog(e.data.toString());
            list.add(OfferInfoEntity().fromJson(e.data));
          }
        });
      });
      await driverOfferCollection.getDocuments().then((value) {
        value.documents.forEach((e) {
          if (e.data != null && e.data['customer_id'] == user.customer_id) {
            printLog(e.data.toString());
            list.add(OfferInfoEntity().fromJson(e.data));
          }
        });
      });
    }
    printLog(list.toString());
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

  static void printLog(dynamic data) {
    BaseRepository.logger.e(data);
  }
}

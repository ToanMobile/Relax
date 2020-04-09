import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/service/dio_utils.dart';
import 'package:relax/data/service/http_api.dart';

import 'base_repository.dart';

class HomeRepository {
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
          //_onError(code, msg, onError);
        }
    );
  }

  static void printLog(dynamic data){
    BaseRepository.logger.e(data);
  }
}

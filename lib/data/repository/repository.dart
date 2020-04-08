import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/model/register_entity.dart';
import 'package:relax/data/service/dio_utils.dart';
import 'package:relax/data/service/http_api.dart';
import 'package:logger/logger.dart';

class Repository {
  static var logger = Logger(
    printer: PrettyPrinter(),
  );

  void asyncRequestNetwork<T>(Method method, {@required String url, bool isShow: true, bool isClose: true, Function(T t) onSuccess, Function(List<
      T> list) onSuccessList, Function(int code, String msg) onError,
    dynamic params, Map<String, dynamic> queryParameters, CancelToken cancelToken, Options options, bool isList: false}) {
    DioUtils.instance.asyncRequestNetwork<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken ?? null,
        isList: isList,
        onSuccess: (data) {
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onSuccessList: (data) {
          if (onSuccessList != null) {
            onSuccessList(data);
          }
        },
        onError: (code, msg) {
          //_onError(code, msg, onError);
        }
    );
  }

  static Future login(String username, String password) async {
    Map<String, String> params = Map();
    params["identifier"] = username;
    params["password"] = password;

    return DioUtils.instance.asyncRequestNetwork<LoginEntity>(Method.post, HttpApi.login,
        params: params,
        onSuccess: (data) {
          if (data != null) {
            logger.e(data);
          }
        },
        onSuccessList: (data) {
          if (data != null) {
            logger.e(data);
          }
        },
        onError: (code, msg) {
          logger.e("$msg code=$code");
          //_onError(code, msg, onError);
        }
    );
  }

  static Future logout() async {
    return DioUtils.instance.asyncRequestNetwork<RegisterEntity>(Method.post, HttpApi.login,
        onSuccess: (data) {
          if (data != null) {
            logger.e(data);
          }
        },
        onSuccessList: (data) {
          if (data != null) {
            logger.e(data);
          }
        },
        onError: (code, msg) {
          logger.e("$msg code=$code");
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
            logger.e(data);
          }
        },
        onSuccessList: (data) {
          if (data != null) {
            logger.e(data);
          }
        },
        onError: (code, msg) {
          logger.e("$msg code=$code");
        }
    );
  }
}

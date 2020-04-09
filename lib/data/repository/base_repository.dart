import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:relax/data/service/dio_utils.dart';

class BaseRepository {
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
}

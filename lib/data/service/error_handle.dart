import 'dart:io';

import 'package:dio/dio.dart';

class ExceptionHandle {
  static const int success = 200;
  static const int success_not_content = 204;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int not_found = 404;

  static const int net_error = 1000;
  static const int parse_error = 1001;
  static const int socket_error = 1002;
  static const int http_error = 1003;
  static const int timeout_error = 1004;
  static const int cancel_error = 1005;
  static const int unknown_error = 9999;

  static NetError handleException(dynamic error) {
    print(error);
    if (error is DioError) {
      if (error.type == DioErrorType.DEFAULT || 
          error.type == DioErrorType.RESPONSE) {
        dynamic e = error.error;
        if (e is SocketException) {
          return NetError(socket_error, "Internet error, Please check internet！");
        }
        if (e is HttpException) {
          return NetError(http_error, "HttpException！");
        }
        return NetError(net_error, "Internet error, Please check internet！");
      } else if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.SEND_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT) {
        return NetError(timeout_error, "Time Out！");
      } else if (error.type == DioErrorType.CANCEL) {
        return NetError(cancel_error, "Cancel");
      } else {
        return NetError(unknown_error, "Unknown Error");
      }
    } else {
      return NetError(unknown_error, "Unknown Error");
    }
  }
}

class NetError{
  int code;
  String msg;

  NetError(this.code, this.msg);
}
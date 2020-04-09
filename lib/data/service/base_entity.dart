import 'package:relax/generated/json/base/json_convert_content.dart';

import '../../common/constant.dart';

class BaseEntity<T> {
  int code;
  String message;
  T data;
  List<T> listData = [];

  BaseEntity(this.code, this.message, this.data);

  BaseEntity.fromJsonWithKey(Map<String, dynamic> json) {
    code = json[Constant.code];
    message = json[Constant.message];
    if (json.containsKey(Constant.data)) {
      if (json[Constant.data] is List) {
        (json[Constant.data] as List).forEach((item) {
          listData.add(_generateOBJ<T>(item));
        });
      } else {
        data = _generateOBJ(json[Constant.data]);
      }
    }
  }

  BaseEntity.fromJson(dynamic json) {
    if (json is List) {
      json.forEach((item) {
        listData.add(_generateOBJ<T>(item));
      });
    } else {
      data = _generateOBJ(json);
    }
  }

  S _generateOBJ<S>(json) {
    if (S.toString() == "String") {
      return json.toString() as S;
    } else if (T.toString() == "Map<dynamic, dynamic>") {
      return json as S;
    } else {
      return JsonConvert.fromJsonAsT(json);
    }
  }
}

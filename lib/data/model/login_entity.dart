import 'package:relax/generated/json/base/json_convert_content.dart';

class LoginEntity with JsonConvert<LoginEntity> {
  String uid;

  LoginEntity({this.uid});
}

class LoginUser with JsonConvert<LoginUser> {
  String uid;
  String address;
  String name;
  int role; // role =1; shipper; role = 2; driver; role = 3 driver and shipper
  String tel;

  LoginUser({this.uid, this.address, this.name, this.role, this.tel});
}

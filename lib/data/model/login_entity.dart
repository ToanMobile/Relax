import 'package:relax/generated/json/base/json_convert_content.dart';

class LoginEntity with JsonConvert<LoginEntity> {
  String uid = '';
  String address = '';
  String name = '';
  int role = 0; // role =1; shipper; role = 2; driver; role = 3 driver and shipper
  String tel = '';

  @override
  String toString() {
    return 'LoginEntity{uid: $uid, address: $address, name: $name, role: $role, tel: $tel}';
  }
}

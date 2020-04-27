import 'package:relax/generated/json/base/json_convert_content.dart';

class LoginEntity with JsonConvert<LoginEntity> {
  String uid = '';
  int customer_id = 0;
  String address = '';
  String name = '';
  String email = '';
  int role = 0; // role =1; shipper; role = 2; driver; role = 3 driver and shipper
  String tel = '';

  @override
  String toString() {
    return 'LoginEntity{uid: $uid, customer_id:$customer_id, address: $address, name: $name, email:$email, role: $role, tel: $tel}';
  }
}

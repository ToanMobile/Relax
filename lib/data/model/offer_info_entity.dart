import 'package:relax/generated/json/base/json_convert_content.dart';

class OfferInfoEntity with JsonConvert<OfferInfoEntity> {
  String uid;
  String from_address;
  String to_address;
  DateTime from_workingtime;

  DateTime to_workingtime;
  int vehicle_id;
  DateTime created_at;

  //Shipper
  String pickup_Address;
  String drop_Address;
  DateTime pickup_Time;
  String guest_Name;
  String guest_Address;
  String guest_Phone;

  @override
  String toString() {
    return 'OfferInfoEntity{uid: $uid, from_address: $from_address, to_address: $to_address, from_workingtime: $from_workingtime, to_workingtime: $to_workingtime, vehicle_id: $vehicle_id, created_at: $created_at, pickup_Address: $pickup_Address, drop_Address: $drop_Address, pickup_Time: $pickup_Time, guest_Name: $guest_Name, guest_Address: $guest_Address, guest_Phone: $guest_Phone}';
  }

}

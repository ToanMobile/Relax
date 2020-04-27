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
}

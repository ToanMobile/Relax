import 'package:relax/generated/json/base/json_convert_content.dart';

class DriverOfferEntity with JsonConvert<DriverOfferEntity> {
  String uid;
  String client_Id;
  String offer_id;
  String offer_status; // default 0
  String from_address;
  double from_lat;
  double from_lon;
  String to_address;
  double to_lat;
  double to_lon;
  DateTime from_workingtime;
  DateTime to_workingtime;
  int vehicle_id;
  String vehicle_name;
  DateTime created_at;
}

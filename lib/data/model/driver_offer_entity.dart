import 'package:relax/generated/json/base/json_convert_content.dart';

class DriverOfferEntity with JsonConvert<DriverOfferEntity> {
  String uid;
  String client_Id;
  int customer_id;
  String offer_id;
  int offer_status = 0; // default 0
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

  @override
  String toString() {
    return 'DriverOfferEntity{uid: $uid, client_Id: $client_Id, customer_id: $customer_id, offer_id: $offer_id, offer_status: $offer_status, from_address: $from_address, from_lat: $from_lat, from_lon: $from_lon, to_address: $to_address, to_lat: $to_lat, to_lon: $to_lon, from_workingtime: $from_workingtime, to_workingtime: $to_workingtime, vehicle_id: $vehicle_id, vehicle_name: $vehicle_name, created_at: $created_at}';
  }
}

import 'package:relax/generated/json/base/json_convert_content.dart';

class RequestInfo with JsonConvert<RequestInfo> {
  int client_Id;
  int userid;
  int requestId;
  int status;
  int fahrer_Id;
  int transportmittel_Id;
  String pickup_Address;
  double pickup_Lat;
  double pickup_Lon;
  int pickup_Status;
  DateTime pickup_Time;
  String drop_Address;
  double drop_Lat;
  double drop_Lon;
  int request_Status;
  double weight;
  double hight;
  double width;
  double length;
  String packaging_kind;
  int customer_id;
  int countOfparcels;
  double distance;
  DateTime created_at; //timestemp

  @override
  String toString() {
    return 'RequestInfo{client_Id: $client_Id, userid: $userid, requestId: $requestId, status: $status, fahrer_Id: $fahrer_Id, transportmittel_Id: $transportmittel_Id, pickup_Address: $pickup_Address, pickup_Lat: $pickup_Lat, pickup_Lon: $pickup_Lon, pickup_Status: $pickup_Status, pickup_Time: $pickup_Time, drop_Address: $drop_Address, drop_Lat: $drop_Lat, drop_Lon: $drop_Lon, request_Status: $request_Status, weight: $weight, hight: $hight, width: $width, length: $length, packaging_kind: $packaging_kind, customer_id: $customer_id, countOfparcels: $countOfparcels, distance: $distance, created_at: $created_at}';
  }
}

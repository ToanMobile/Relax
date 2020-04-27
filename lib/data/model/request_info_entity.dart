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
  DateTime created_at;  //timestemp
}

class RequestInfo {
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
  int countOfparcels;
  double distance;
  DateTime created_at;  //timestemp
  RequestInfo({ this.client_Id, this.userid,this.requestId, this.status, this.fahrer_Id, this.transportmittel_Id, this.pickup_Address,
                        this.pickup_Lat, this.pickup_Lon, this.pickup_Status, this.pickup_Time, 
                        this.drop_Address, this.drop_Lat, this.drop_Lon, this.request_Status,
                        this.weight, this.hight, this.width, this.length, this.packaging_kind,this.countOfparcels,
                        this.distance,this.created_at });
}

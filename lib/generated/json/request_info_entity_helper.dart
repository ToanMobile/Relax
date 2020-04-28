import 'package:relax/data/model/request_info_entity.dart';

requestInfoFromJson(RequestInfo data, Map<String, dynamic> json) {
	if (json['client_Id'] != null) {
		data.client_Id = json['client_Id']?.toInt();
	}
	if (json['userid'] != null) {
		data.userid = json['userid']?.toInt();
	}
	if (json['requestId'] != null) {
		data.requestId = json['requestId']?.toInt();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['fahrer_Id'] != null) {
		data.fahrer_Id = json['fahrer_Id']?.toInt();
	}
	if (json['transportmittel_Id'] != null) {
		data.transportmittel_Id = json['transportmittel_Id']?.toInt();
	}
	if (json['pickup_Address'] != null) {
		data.pickup_Address = json['pickup_Address']?.toString();
	}
	if (json['pickup_Lat'] != null) {
		data.pickup_Lat = json['pickup_Lat']?.toDouble();
	}
	if (json['pickup_Lon'] != null) {
		data.pickup_Lon = json['pickup_Lon']?.toDouble();
	}
	if (json['pickup_Status'] != null) {
		data.pickup_Status = json['pickup_Status']?.toInt();
	}
	if(json['pickup_Time'] != null){
		data.pickup_Time = DateTime.tryParse(json['pickup_Time']);
	}
	if (json['drop_Address'] != null) {
		data.drop_Address = json['drop_Address']?.toString();
	}
	if (json['drop_Lat'] != null) {
		data.drop_Lat = json['drop_Lat']?.toDouble();
	}
	if (json['drop_Lon'] != null) {
		data.drop_Lon = json['drop_Lon']?.toDouble();
	}
	if (json['request_Status'] != null) {
		data.request_Status = json['request_Status']?.toInt();
	}
	if (json['weight'] != null) {
		data.weight = json['weight']?.toDouble();
	}
	if (json['hight'] != null) {
		data.hight = json['hight']?.toDouble();
	}
	if (json['width'] != null) {
		data.width = json['width']?.toDouble();
	}
	if (json['length'] != null) {
		data.length = json['length']?.toDouble();
	}
	if (json['packaging_kind'] != null) {
		data.packaging_kind = json['packaging_kind']?.toString();
	}
	if (json['customer_id'] != null) {
		data.customer_id = json['customer_id']?.toInt();
	}
	if (json['countOfparcels'] != null) {
		data.countOfparcels = json['countOfparcels']?.toInt();
	}
	if (json['distance'] != null) {
		data.distance = json['distance']?.toDouble();
	}
	if(json['created_at'] != null){
		data.created_at = DateTime.tryParse(json['created_at']);
	}
	if (json['guest_Name'] != null) {
		data.guest_Name = json['guest_Name']?.toString();
	}
	if (json['guest_Address'] != null) {
		data.guest_Address = json['guest_Address']?.toString();
	}
	if (json['guest_Phone'] != null) {
		data.guest_Phone = json['guest_Phone']?.toString();
	}
	return data;
}

Map<String, dynamic> requestInfoToJson(RequestInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['client_Id'] = entity.client_Id;
	data['userid'] = entity.userid;
	data['requestId'] = entity.requestId;
	data['status'] = entity.status;
	data['fahrer_Id'] = entity.fahrer_Id;
	data['transportmittel_Id'] = entity.transportmittel_Id;
	data['pickup_Address'] = entity.pickup_Address;
	data['pickup_Lat'] = entity.pickup_Lat;
	data['pickup_Lon'] = entity.pickup_Lon;
	data['pickup_Status'] = entity.pickup_Status;
	data['pickup_Time'] = entity.pickup_Time?.toString();
	data['drop_Address'] = entity.drop_Address;
	data['drop_Lat'] = entity.drop_Lat;
	data['drop_Lon'] = entity.drop_Lon;
	data['request_Status'] = entity.request_Status;
	data['weight'] = entity.weight;
	data['hight'] = entity.hight;
	data['width'] = entity.width;
	data['length'] = entity.length;
	data['packaging_kind'] = entity.packaging_kind;
	data['customer_id'] = entity.customer_id;
	data['countOfparcels'] = entity.countOfparcels;
	data['distance'] = entity.distance;
	data['created_at'] = entity.created_at?.toString();
	data['guest_Name'] = entity.guest_Name;
	data['guest_Address'] = entity.guest_Address;
	data['guest_Phone'] = entity.guest_Phone;
	return data;
}
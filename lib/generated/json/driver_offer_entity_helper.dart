import 'package:relax/data/model/driver_offer_entity.dart';

driverOfferEntityFromJson(DriverOfferEntity data, Map<String, dynamic> json) {
	if (json['uid'] != null) {
		data.uid = json['uid']?.toString();
	}
	if (json['client_Id'] != null) {
		data.client_Id = json['client_Id']?.toString();
	}
	if (json['offer_id'] != null) {
		data.offer_id = json['offer_id']?.toString();
	}
	if (json['offer_status'] != null) {
		data.offer_status = json['offer_status']?.toString();
	}
	if (json['from_address'] != null) {
		data.from_address = json['from_address']?.toString();
	}
	if (json['from_lat'] != null) {
		data.from_lat = json['from_lat']?.toDouble();
	}
	if (json['from_lon'] != null) {
		data.from_lon = json['from_lon']?.toDouble();
	}
	if (json['to_address'] != null) {
		data.to_address = json['to_address']?.toString();
	}
	if (json['to_lat'] != null) {
		data.to_lat = json['to_lat']?.toDouble();
	}
	if (json['to_lon'] != null) {
		data.to_lon = json['to_lon']?.toDouble();
	}
	if(json['from_workingtime'] != null){
		data.from_workingtime = DateTime.tryParse(json['from_workingtime']);
	}
	if(json['to_workingtime'] != null){
		data.to_workingtime = DateTime.tryParse(json['to_workingtime']);
	}
	if (json['vehicle_id'] != null) {
		data.vehicle_id = json['vehicle_id']?.toInt();
	}
	if(json['created_at'] != null){
		data.created_at = DateTime.tryParse(json['created_at']);
	}
	return data;
}

Map<String, dynamic> driverOfferEntityToJson(DriverOfferEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uid'] = entity.uid;
	data['client_Id'] = entity.client_Id;
	data['offer_id'] = entity.offer_id;
	data['offer_status'] = entity.offer_status;
	data['from_address'] = entity.from_address;
	data['from_lat'] = entity.from_lat;
	data['from_lon'] = entity.from_lon;
	data['to_address'] = entity.to_address;
	data['to_lat'] = entity.to_lat;
	data['to_lon'] = entity.to_lon;
	data['from_workingtime'] = entity.from_workingtime?.toString();
	data['to_workingtime'] = entity.to_workingtime?.toString();
	data['vehicle_id'] = entity.vehicle_id;
	data['created_at'] = entity.created_at?.toString();
	return data;
}
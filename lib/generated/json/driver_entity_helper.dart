import 'package:relax/data/model/driver_entity.dart';
import 'package:relax/data/model/place_item_res.dart';

driverEntityFromJson(DriverEntity data, Map<String, dynamic> json) {
	if (json['uid'] != null) {
		data.uid = json['uid']?.toString();
	}
	if (json['imgLicence'] != null) {
		data.imgLicence = json['imgLicence']?.toString();
	}
	if (json['imgDriver'] != null) {
		data.imgDriver = json['imgDriver']?.toString();
	}
	if (json['imgCertificate'] != null) {
		data.imgCertificate = json['imgCertificate']?.toString();
	}
	if (json['email'] != null) {
		data.email = json['email']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	if(json['fromTime'] != null){
		data.fromTime = DateTime.tryParse(json['fromTime']);
	}
	if(json['toTime'] != null){
		data.toTime = DateTime.tryParse(json['toTime']);
	}
	if (json['fromLocation'] != null) {
		data.fromLocation = new PlaceItemRes().fromJson(json['fromLocation']);
	}
	if (json['toLocation'] != null) {
		data.toLocation = new PlaceItemRes().fromJson(json['toLocation']);
	}
	return data;
}

Map<String, dynamic> driverEntityToJson(DriverEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uid'] = entity.uid;
	data['imgLicence'] = entity.imgLicence;
	data['imgDriver'] = entity.imgDriver;
	data['imgCertificate'] = entity.imgCertificate;
	data['email'] = entity.email;
	data['status'] = entity.status;
	data['fromTime'] = entity.fromTime?.toString();
	data['toTime'] = entity.toTime?.toString();
	if (entity.fromLocation != null) {
		data['fromLocation'] = entity.fromLocation.toJson();
	}
	if (entity.toLocation != null) {
		data['toLocation'] = entity.toLocation.toJson();
	}
	return data;
}
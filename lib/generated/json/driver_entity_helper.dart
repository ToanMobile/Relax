import 'package:relax/data/model/driver_entity.dart';

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
	if (json['fromTime'] != null) {
		data.fromTime = json['fromTime']?.toString();
	}
	if (json['toTime'] != null) {
		data.toTime = json['toTime']?.toString();
	}
	if (json['fromLocation'] != null) {
		data.fromLocation = json['fromLocation']?.toString();
	}
	if (json['toLocation'] != null) {
		data.toLocation = json['toLocation']?.toString();
	}
	if (json['lat'] != null) {
		data.lat = json['lat']?.toDouble();
	}
	if (json['lng'] != null) {
		data.lng = json['lng']?.toDouble();
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
	data['fromTime'] = entity.fromTime;
	data['toTime'] = entity.toTime;
	data['fromLocation'] = entity.fromLocation;
	data['toLocation'] = entity.toLocation;
	data['lat'] = entity.lat;
	data['lng'] = entity.lng;
	return data;
}
import 'package:relax/data/model/driver_entity.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/model/verhicle_entity.dart';

driverEntityFromJson(DriverEntity data, Map<String, dynamic> json) {
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
	if (json['user'] != null) {
		data.user = new LoginEntity().fromJson(json['user']);
	}
	if (json['vehicleEntity'] != null) {
		data.vehicleEntity = new VehicleEntity().fromJson(json['vehicleEntity']);
	}
	return data;
}

Map<String, dynamic> driverEntityToJson(DriverEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.imgLicence != null) {
		data['imgLicence'] = entity.imgLicence;
	}
	if (entity.imgDriver != null) {
		data['imgDriver'] = entity.imgDriver;
	}
	if (entity.imgCertificate != null) {
		data['imgCertificate'] = entity.imgCertificate;
	}
	if (entity.email != null) {
		data['email'] = entity.email;
	}
	if (entity.status != null) {
		data['status'] = entity.status;
	}
	if (entity.fromTime != null) {
		data['fromTime'] = entity.fromTime?.toString();
	}
	if (entity.toTime != null) {
		data['toTime'] = entity.toTime?.toString();
	}
	if (entity.fromLocation != null) {
		data['fromLocation'] = entity.fromLocation.toJson();
	}
	if (entity.toLocation != null) {
		data['toLocation'] = entity.toLocation.toJson();
	}
	if (entity.user != null) {
		data['user'] = entity.user.toJson();
	}
	if (entity.vehicleEntity != null) {
		data['vehicleEntity'] = entity.vehicleEntity.toJson();
	}
	return data;
}
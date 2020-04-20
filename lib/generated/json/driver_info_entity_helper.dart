import 'package:relax/data/model/driver_info_entity.dart';

driverInfoEntityFromJson(DriverInfoEntity data, Map<String, dynamic> json) {
	if (json['imgLicence'] != null) {
		data.imgLicence = json['imgLicence']?.toString();
	}
	if (json['imgDriver'] != null) {
		data.imgDriver = json['imgDriver']?.toString();
	}
	if (json['imgCertificate'] != null) {
		data.imgCertificate = json['imgCertificate']?.toString();
	}
	if (json['uid'] != null) {
		data.uid = json['uid']?.toString();
	}
	if (json['driver_status'] != null) {
		data.driver_status = json['driver_status']?.toString();
	}
	return data;
}

Map<String, dynamic> driverInfoEntityToJson(DriverInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['imgLicence'] = entity.imgLicence;
	data['imgDriver'] = entity.imgDriver;
	data['imgCertificate'] = entity.imgCertificate;
	data['uid'] = entity.uid;
	data['driver_status'] = entity.driver_status;
	return data;
}
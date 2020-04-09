import 'package:relax/data/model/login_entity.dart';

loginEntityFromJson(LoginEntity data, Map<String, dynamic> json) {
	if (json['uid'] != null) {
		data.uid = json['uid']?.toString();
	}
	if (json['address'] != null) {
		data.address = json['address']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['role'] != null) {
		data.role = json['role']?.toInt();
	}
	if (json['tel'] != null) {
		data.tel = json['tel']?.toString();
	}
	return data;
}

Map<String, dynamic> loginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uid'] = entity.uid;
	data['address'] = entity.address;
	data['name'] = entity.name;
	data['role'] = entity.role;
	data['tel'] = entity.tel;
	return data;
}
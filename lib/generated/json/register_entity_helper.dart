import 'package:relax/data/model/register_entity.dart';

registerEntityFromJson(RegisterEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['jwt'] != null) {
		data.jwt = json['jwt']?.toString();
	}
	if (json['expiredDate'] != null) {
		data.expiredDate = json['expiredDate']?.toString();
	}
	if (json['user'] != null) {
		data.user = new RegisterUser().fromJson(json['user']);
	}
	return data;
}

Map<String, dynamic> registerEntityToJson(RegisterEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['jwt'] = entity.jwt;
	data['expiredDate'] = entity.expiredDate;
	if (entity.user != null) {
		data['user'] = entity.user.toJson();
	}
	return data;
}

registerUserFromJson(RegisterUser data, Map<String, dynamic> json) {
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['email'] != null) {
		data.email = json['email']?.toString();
	}
	if (json['provider'] != null) {
		data.provider = json['provider']?.toString();
	}
	if (json['uuid'] != null) {
		data.uuid = json['uuid']?.toString();
	}
	if (json['shortcode'] != null) {
		data.shortcode = json['shortcode']?.toString();
	}
	if (json['role'] != null) {
		data.role = json['role']?.toInt();
	}
	if (json['confirmed'] != null) {
		data.confirmed = json['confirmed'];
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	return data;
}

Map<String, dynamic> registerUserToJson(RegisterUser entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['username'] = entity.username;
	data['email'] = entity.email;
	data['provider'] = entity.provider;
	data['uuid'] = entity.uuid;
	data['shortcode'] = entity.shortcode;
	data['role'] = entity.role;
	data['confirmed'] = entity.confirmed;
	data['id'] = entity.id;
	return data;
}
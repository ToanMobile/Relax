import 'package:relax/data/model/login_entity.dart';

loginEntityFromJson(LoginEntity data, Map<String, dynamic> json) {
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
		data.user = new LoginUser().fromJson(json['user']);
	}
	return data;
}

Map<String, dynamic> loginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['jwt'] = entity.jwt;
	data['expiredDate'] = entity.expiredDate;
	if (entity.user != null) {
		data['user'] = entity.user.toJson();
	}
	return data;
}

loginUserFromJson(LoginUser data, Map<String, dynamic> json) {
	if (json['email'] != null) {
		data.email = json['email']?.toString();
	}
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['uuid'] != null) {
		data.uuid = json['uuid']?.toString();
	}
	if (json['username'] != null) {
		data.username = json['username']?.toString();
	}
	if (json['provider'] != null) {
		data.provider = json['provider']?.toString();
	}
	if (json['confirmed'] != null) {
		data.confirmed = json['confirmed'];
	}
	if (json['blocked'] != null) {
		data.blocked = json['blocked'];
	}
	if (json['role'] != null) {
		data.role = new LoginUserRole().fromJson(json['role']);
	}
	if (json['shortcode'] != null) {
		data.shortcode = json['shortcode']?.toString();
	}
	return data;
}

Map<String, dynamic> loginUserToJson(LoginUser entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['email'] = entity.email;
	data['id'] = entity.id;
	data['uuid'] = entity.uuid;
	data['username'] = entity.username;
	data['provider'] = entity.provider;
	data['confirmed'] = entity.confirmed;
	data['blocked'] = entity.blocked;
	if (entity.role != null) {
		data['role'] = entity.role.toJson();
	}
	data['shortcode'] = entity.shortcode;
	return data;
}

loginUserRoleFromJson(LoginUserRole data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['description'] != null) {
		data.description = json['description']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	return data;
}

Map<String, dynamic> loginUserRoleToJson(LoginUserRole entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['description'] = entity.description;
	data['type'] = entity.type;
	return data;
}
import 'package:relax/data/model/login_entity.dart';

loginEntityFromJson(LoginEntity data, Map<String, dynamic> json) {
	if (json['uid'] != null) {
		data.uid = json['uid']?.toString();
	}
	if (json['customer_id'] != null) {
		data.customer_id = json['customer_id']?.toInt();
	}
	if (json['address'] != null) {
		data.address = json['address']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['email'] != null) {
		data.email = json['email']?.toString();
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
	data['customer_id'] = entity.customer_id;
	data['address'] = entity.address;
	data['name'] = entity.name;
	data['email'] = entity.email;
	data['role'] = entity.role;
	data['tel'] = entity.tel;
	return data;
}
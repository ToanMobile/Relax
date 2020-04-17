import 'package:relax/data/model/verhicle_entity.dart';

vehicleEntityFromJson(VehicleEntity data, Map<String, dynamic> json) {
	if (json['description'] != null) {
		data.description = json['description']?.toString();
	}
	if (json['height'] != null) {
		data.height = json['height']?.toInt();
	}
	if (json['length'] != null) {
		data.length = json['length']?.toInt();
	}
	if (json['max_weight'] != null) {
		data.max_weight = json['max_weight']?.toInt();
	}
	if (json['resource_id'] != null) {
		data.resource_id = json['resource_id']?.toInt();
	}
	if (json['width'] != null) {
		data.width = json['width']?.toInt();
	}
	if (json['visible'] != null) {
		data.visible = json['visible'];
	}
	return data;
}

Map<String, dynamic> vehicleEntityToJson(VehicleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['description'] = entity.description;
	data['height'] = entity.height;
	data['length'] = entity.length;
	data['max_weight'] = entity.max_weight;
	data['resource_id'] = entity.resource_id;
	data['width'] = entity.width;
	data['visible'] = entity.visible;
	return data;
}
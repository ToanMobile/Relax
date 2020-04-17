import 'package:relax/data/model/place_item_res.dart';

placeItemResFromJson(PlaceItemRes data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['address'] != null) {
		data.address = json['address']?.toString();
	}
	if (json['lat'] != null) {
		data.lat = json['lat']?.toDouble();
	}
	if (json['lng'] != null) {
		data.lng = json['lng']?.toDouble();
	}
	return data;
}

Map<String, dynamic> placeItemResToJson(PlaceItemRes entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['address'] = entity.address;
	data['lat'] = entity.lat;
	data['lng'] = entity.lng;
	return data;
}
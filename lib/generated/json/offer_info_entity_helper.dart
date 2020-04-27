import 'package:relax/data/model/offer_info_entity.dart';

offerInfoEntityFromJson(OfferInfoEntity data, Map<String, dynamic> json) {
	if (json['uid'] != null) {
		data.uid = json['uid']?.toString();
	}
	if (json['from_address'] != null) {
		data.from_address = json['from_address']?.toString();
	}
	if (json['to_address'] != null) {
		data.to_address = json['to_address']?.toString();
	}
	if(json['from_workingtime'] != null){
		data.from_workingtime = DateTime.tryParse(json['from_workingtime']);
	}
	if(json['to_workingtime'] != null){
		data.to_workingtime = DateTime.tryParse(json['to_workingtime']);
	}
	if (json['vehicle_id'] != null) {
		data.vehicle_id = json['vehicle_id']?.toInt();
	}
	if(json['created_at'] != null){
		data.created_at = DateTime.tryParse(json['created_at']);
	}
	if (json['pickup_Address'] != null) {
		data.pickup_Address = json['pickup_Address']?.toString();
	}
	if (json['drop_Address'] != null) {
		data.drop_Address = json['drop_Address']?.toString();
	}
	if(json['pickup_Time'] != null){
		data.pickup_Time = DateTime.tryParse(json['pickup_Time']);
	}
	return data;
}

Map<String, dynamic> offerInfoEntityToJson(OfferInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uid'] = entity.uid;
	data['from_address'] = entity.from_address;
	data['to_address'] = entity.to_address;
	data['from_workingtime'] = entity.from_workingtime?.toString();
	data['to_workingtime'] = entity.to_workingtime?.toString();
	data['vehicle_id'] = entity.vehicle_id;
	data['created_at'] = entity.created_at?.toString();
	data['pickup_Address'] = entity.pickup_Address;
	data['drop_Address'] = entity.drop_Address;
	data['pickup_Time'] = entity.pickup_Time?.toString();
	return data;
}
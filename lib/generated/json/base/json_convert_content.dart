// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:relax/data/model/driver_info_entity.dart';
import 'package:relax/data/model/driver_offer_entity.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/model/offer_info_entity.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/model/register_entity.dart';
import 'package:relax/data/model/request_info_entity.dart';
import 'package:relax/data/model/verhicle_entity.dart';
import 'package:relax/generated/json/driver_info_entity_helper.dart';
import 'package:relax/generated/json/driver_offer_entity_helper.dart';
import 'package:relax/generated/json/login_entity_helper.dart';
import 'package:relax/generated/json/offer_info_entity_helper.dart';
import 'package:relax/generated/json/place_item_res_helper.dart';
import 'package:relax/generated/json/register_entity_helper.dart';
import 'package:relax/generated/json/request_info_entity_helper.dart';
import 'package:relax/generated/json/verhicle_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case LoginEntity:
			return loginEntityFromJson(data as LoginEntity, json) as T;			case VehicleEntity:
			return vehicleEntityFromJson(data as VehicleEntity, json) as T;			case OfferInfoEntity:
			return offerInfoEntityFromJson(data as OfferInfoEntity, json) as T;			case PlaceItemRes:
			return placeItemResFromJson(data as PlaceItemRes, json) as T;			case RequestInfo:
			return requestInfoFromJson(data as RequestInfo, json) as T;			case DriverOfferEntity:
			return driverOfferEntityFromJson(data as DriverOfferEntity, json) as T;			case RegisterEntity:
			return registerEntityFromJson(data as RegisterEntity, json) as T;			case RegisterUser:
			return registerUserFromJson(data as RegisterUser, json) as T;			case DriverInfoEntity:
			return driverInfoEntityFromJson(data as DriverInfoEntity, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {			case LoginEntity:
			return loginEntityToJson(data as LoginEntity);			case VehicleEntity:
			return vehicleEntityToJson(data as VehicleEntity);			case OfferInfoEntity:
			return offerInfoEntityToJson(data as OfferInfoEntity);			case PlaceItemRes:
			return placeItemResToJson(data as PlaceItemRes);			case RequestInfo:
			return requestInfoToJson(data as RequestInfo);			case DriverOfferEntity:
			return driverOfferEntityToJson(data as DriverOfferEntity);			case RegisterEntity:
			return registerEntityToJson(data as RegisterEntity);			case RegisterUser:
			return registerUserToJson(data as RegisterUser);			case DriverInfoEntity:
			return driverInfoEntityToJson(data as DriverInfoEntity);    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {			case 'LoginEntity':
			return LoginEntity().fromJson(json);			case 'VehicleEntity':
			return VehicleEntity().fromJson(json);			case 'OfferInfoEntity':
			return OfferInfoEntity().fromJson(json);			case 'PlaceItemRes':
			return PlaceItemRes().fromJson(json);			case 'RequestInfo':
			return RequestInfo().fromJson(json);			case 'DriverOfferEntity':
			return DriverOfferEntity().fromJson(json);			case 'RegisterEntity':
			return RegisterEntity().fromJson(json);			case 'RegisterUser':
			return RegisterUser().fromJson(json);			case 'DriverInfoEntity':
			return DriverInfoEntity().fromJson(json);    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {			case 'LoginEntity':
			return List<LoginEntity>();			case 'VehicleEntity':
			return List<VehicleEntity>();			case 'OfferInfoEntity':
			return List<OfferInfoEntity>();			case 'PlaceItemRes':
			return List<PlaceItemRes>();			case 'RequestInfo':
			return List<RequestInfo>();			case 'DriverOfferEntity':
			return List<DriverOfferEntity>();			case 'RegisterEntity':
			return List<RegisterEntity>();			case 'RegisterUser':
			return List<RegisterUser>();			case 'DriverInfoEntity':
			return List<DriverInfoEntity>();    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}
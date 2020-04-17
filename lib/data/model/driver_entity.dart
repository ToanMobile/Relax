import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';

class DriverEntity with JsonConvert<DriverEntity> {
  String imgLicence;
  String imgDriver;
  String imgCertificate;
  String email;
  String status;
  DateTime fromTime;
  DateTime toTime;
  PlaceItemRes fromLocation;
  PlaceItemRes toLocation;
  LoginEntity user;

  @override
  String toString() {
    return 'DriverEntity{user: $user, imgLicence: $imgLicence, imgDriver: $imgDriver, imgCertificate: $imgCertificate, email: $email, status: $status, fromTime: $fromTime, toTime: $toTime, fromLocation: $fromLocation, toLocation: $toLocation}';
  }
}

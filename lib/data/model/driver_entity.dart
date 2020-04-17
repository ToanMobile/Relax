import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';

class DriverEntity with JsonConvert<DriverEntity> {
  String uid = '';
  String imgLicence = '';
  String imgDriver = '';
  String imgCertificate = '';
  String email = '';
  String status = '';
  DateTime fromTime;
  DateTime toTime;
  PlaceItemRes fromLocation;
  PlaceItemRes toLocation;

  @override
  String toString() {
    return 'DriverEntity{uid: $uid, email=$email, status=$status, imgLicence: $imgLicence, imgDriver: $imgDriver, imgCertificate: $imgCertificate}';
  }
}

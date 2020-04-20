import 'package:relax/generated/json/base/json_convert_content.dart';

class DriverInfoEntity with JsonConvert<DriverInfoEntity> {
  String imgLicence;
  String imgDriver;
  String imgCertificate;
  String uid;
  String driver_status;

  @override
  String toString() {
    return 'DriverInfoEntity{imgLicence: $imgLicence, imgDriver: $imgDriver, imgCertificate: $imgCertificate, uid: $uid, driver_status: $driver_status}';
  }

}

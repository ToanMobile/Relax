import 'package:relax/generated/json/base/json_convert_content.dart';

class PlaceItemRes with JsonConvert<PlaceItemRes> {
  String name;
  String address;
  double lat;
  double lng;

  static List<PlaceItemRes> fromJsonMap(Map<String, dynamic> json) {
    List<PlaceItemRes> rs = new List();
    var results = json['results'] as List;
    print("parse data" + results.toString());
    for (var item in results) {
      var p = new PlaceItemRes();
      p.name = item['name'];
      p.address = item['formatted_address'];
      p.lat = item['geometry']['location']['lat'];
      p.lng = item['geometry']['location']['lng'];
      rs.add(p);
    }
    return rs;
  }
}

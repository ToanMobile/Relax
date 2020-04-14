class PlaceItemRes {
  String name;
  String address;
  double lat;
  double lng;
  PlaceItemRes(this.name, this.address, this.lat, this.lng);

  static List<PlaceItemRes> fromJson(Map<String, dynamic> json) {
    List<PlaceItemRes> rs = new List();

    var results = json['results'] as List;
    print("parse data"+ results.toString());
    for (var item in results) {
      var p = new PlaceItemRes(
          item['name'],
          item['formatted_address'],
          item['geometry']['location']['lat'],
          item['geometry']['location']['lng']);
          
      rs.add(p);
    }

    return rs;
  }
}

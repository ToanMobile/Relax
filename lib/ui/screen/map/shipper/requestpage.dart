import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/model/requestInfo.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:relax/data/model/step_res.dart';
import 'package:relax/data/model/trip_info_res.dart';
import 'package:relax/data/model/verhicle_entity.dart';
import 'package:relax/data/repository/map_repository.dart';
import 'package:relax/ui/screen/map/home_menu.dart';
import 'package:relax/ui/screen/map/shiper/ride_picker.dart';

import '../basic_datetime.dart';
import '../packaging_pickup.dart';

class PickupDropHomePage extends StatefulWidget {
   static const mapKey = "AIzaSyAdH-Drq0svd8QQV_jUq7kmYjBPKNPYx4c";
  @override
  _PickupDropHomePageState createState() => _PickupDropHomePageState();     
}

class _PickupDropHomePageState extends State<PickupDropHomePage> {
  final CollectionReference requestCollection = Firestore.instance.collection('requestPool');
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  double _tripDistance = 0;
  final RequestInfo request = new RequestInfo();    
  String selectedPackaging;
  DateTime pickuptime;
  final Map<String, Marker> markers = <String, Marker>{};  
  GoogleMapController _mapController;
  int _polylineCount = 1;
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  GoogleMapPolyline _googleMapPolyline = new GoogleMapPolyline(apiKey: "AIzaSyAdH-Drq0svd8QQV_jUq7kmYjBPKNPYx4c");
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.brown[400],
        child: Stack(
          children: <Widget>[
            GoogleMap(
             // key: mapKey,
              markers: Set.of(markers.values),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(50.7331535, 7.0842345),
                zoom: 14.4746,
              ),
              polylines: Set<Polyline>.of(_polylines.values),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Text(
                      "Relax App",
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: FlatButton(
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Image.asset("ic_menu.png")),
                    actions: <Widget>[
                      FlatButton.icon(             
                      icon: Icon(Icons.call_made), 
                      label: Text('go'),
                      onPressed:  addrequest,
                      )
                      ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, left: 20, right: 20),
                    child: RidePicker(onPlaceSelected, onDateTimeselected, onVehicleselected),
                  ),                  
                ],
              ),
            ),
           /* Positioned(left: 20, right: 20, bottom: 10, height: 90,
                child: MyDateTimePage(),
            )     */
          ],
        ),
      ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }
  
  
  Future<void> addrequest() async {
    // add requestinfo to request
    await requestCollection.add(<String, dynamic>{
      'client_Id' :  0,
      'customer_Id' : 1,
      'requestId' :  1,
      'status' :  0,  // 1 nicht begonnen, 2 begonnen, 3 beendet
      'fahrer_Id' :  -1,  // Fahrer Id ist leer wenn  Auftrag Id noch nicht vergeben
      'transportmittel_Id' :  0,  // bedeutet hier die min. Fahrzeuggröße, die der Auftrag erfordert
      'pickup_Address' :   markers["from_address"].infoWindow.snippet,
      'pickup_Lat' :  markers["from_address"].position.latitude,
      'pickup_Lon' :  markers["from_address"].position.longitude,
      'pickup_Status' :  1,// 1: noch nicht abgeholt; 2 unterweg
      'pickup_Time' :  "",//BasicDateTimeField().datum,
      'drop_Address' :  markers["to_address"].infoWindow.snippet,
      'drop_Lat' :  markers["to_address"].position.latitude,
      'drop_Lon' :  markers["to_address"].position.longitude,
      'request_Status' :  -1, // ( = -1, bei request mitteilen)
      'weight' :  0,
      'hight' :  0,
      'width' :  0,
      'length' : 0,
      'packing_kind' :  selectedPackaging,
      'created_at' : DateTime.now(),
      'distance' : _tripDistance,
      'countOfParcels': 1,    
        
    });

    }
      
 
  void onPackagingselected(PackagingItem pack) {  
    request.packaging_kind = pack.name;  
    print("$selectedPackaging");
  }

  void onDateTimeselected(DateTime date, bool time) {

  }

  void onVehicleselected(VehicleEntity pack) {

  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
    _addMarker(mkId, place);
    _moveCamera();
    _checkDrawPolyline();    
  }
  
void _addMarker(String mkId, PlaceItemRes place) async {
      markers.remove(mkId);
  final String markerIdVal = mkId;
  print(place.address);
  final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        place.lat, place.lng
      ),
      infoWindow: InfoWindow(title: place.name, snippet: place.address),      
    );
    setState(() {
      markers[mkId] = marker;
    });       
  } 

  void _moveCamera() {
    print("move camera: ");
    if (markers.values.length > 1) {
      var fromLatLng = markers["from_address"].position;
      var toLatLng = markers["to_address"].position;
      var sLat, sLng, nLat, nLng;
      if(fromLatLng.latitude <= toLatLng.latitude) {
        sLat = fromLatLng.latitude;
        nLat = toLatLng.latitude;
      } else {
        sLat = toLatLng.latitude;
        nLat = fromLatLng.latitude;
      }
      if(fromLatLng.longitude <= toLatLng.longitude) {
        sLng = fromLatLng.longitude;
        nLng = toLatLng.longitude;
      } else {
        sLng = toLatLng.longitude;
        nLng = fromLatLng.longitude;
      }
      LatLngBounds bounds = LatLngBounds(northeast: LatLng(nLat, nLng), southwest: LatLng(sLat, sLng));
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      _mapController.animateCamera(CameraUpdate.newLatLng(
          markers.values.elementAt(0).position));
    }
  }

  void _checkDrawPolyline() {
    if (markers.length > 1) {
      var from = markers["from_address"].position;
      var to = markers["to_address"].position;
      MapRepository.getStep(from.latitude, from.longitude, to.latitude, to.longitude)
          .then((v2) {
            TripInfoRes infoRes = v2;
            _tripDistance = infoRes.distance.toDouble();
            print("distance is $_tripDistance");
            setState(() {
            });
        List<StepsRes> rs = infoRes.steps;
        List<LatLng> paths = new List();
        for (var t in rs) {
          paths.add(LatLng(t.startLocation.latitude, t.startLocation.longitude));
          paths.add(LatLng(t.endLocation.latitude, t.endLocation.longitude));
        }
         _addPolyline(paths);        
      }); 
       
    }
  }
   _addPolyline(List<LatLng> _coordinates) {
    PolylineId id = PolylineId("poly$_polylineCount");
    Polyline polyline = Polyline(
        polylineId: id,        
        color: Colors.blueAccent,
        points: _coordinates,
        width: 7,
        onTap: () {});
    setState(() {
      _polylines[id] = polyline;
      _polylineCount++;
    });
  }
  
}

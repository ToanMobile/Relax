import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:relax/data/model/driver_offer_entity.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/model/step_res.dart';
import 'package:relax/data/model/trip_info_res.dart';
import 'package:relax/data/model/verhicle_entity.dart';
import 'package:relax/data/repository/map_repository.dart';
import 'package:relax/ui/screen/map/shiper/ride_picker.dart';
import 'package:relax/ui/widget/app_bar.dart';
import 'package:relax/viewmodel/driver_model.dart';

import 'home_menu.dart';

class MapPage extends StatefulWidget {
  static const mapKey = "AIzaSyAdH-Drq0svd8QQV_jUq7kmYjBPKNPYx4c";

  @override
  State<StatefulWidget> createState() => MapState();
}

class MapState extends State<MapPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _tripDistance = 0;
  final List<String> steps = [];
  final Map<String, Marker> markers = <String, Marker>{};
  String nextstep = 'weiter =>';
  GoogleMapController _mapController;
  DriverOfferEntity driverOfferEntity;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<DriverModel>.withoutConsumer(
      viewModel: DriverModel(),
      onModelReady: (model) => {},
      builder: (context, model, child) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBarIcon.drawer(
            title: 'Relax App',
            isCenter: true,
            cb: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ).build(context),
          body: Stack(
            children: <Widget>[
              GoogleMap(
                //    key:  mapKey,
                markers: Set.of(markers.values),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(50.7331535, 7.0842345),
                  zoom: 14.4746,
                ),
              ),
              RidePicker(onPlaceSelected, onTimeSelected, onVehicleSelected),
            ],
          ),
          drawer: Drawer(
            child: HomeMenu(),
          ),
          floatingActionButton: buildFloatButton(model),
        );
      },
    );
  }

  Widget buildFloatButton(DriverModel model) {
    Widget child;
    if (model.busy) {
      child = Icon(Icons.send);
    } else {
      child = Icon(Icons.send);
    }
    return FloatingActionButton(
      onPressed: () async {
        print('MapPage==' + driverOfferEntity.toString());
        await model.addDriverOffer(driverOfferEntity).then((value) {
          if (value) {
            print('Done');
          } else {
            model.showErrorMessage(context);
          }
        });
      },
      child: child,
      backgroundColor: Colors.pink,
    );
  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    //print('onPlaceSelected==' + place.toString());
    var mkId = fromAddress ? "from_address" : "to_address";
    if (mkId == "from_address") {
      steps.add('from');
    } else {
      steps.add('to');
    }
    if (fromAddress) {
      driverOfferEntity.from_address = place.address;
      driverOfferEntity.from_lat = place.lat;
      driverOfferEntity.from_lon = place.lng;
    } else {
      driverOfferEntity.to_address = place.address;
      driverOfferEntity.to_lat = place.lat;
      driverOfferEntity.to_lon = place.lng;
    }
    //_add(mkId,place);
    _addMarker(mkId, place);
    _moveCamera();
    _checkDrawPolyline();
  }

  void onTimeSelected(DateTime time, bool fromAddress) {
    if (fromAddress) {
      driverOfferEntity.from_workingtime = time;
    } else {
      driverOfferEntity.to_workingtime = time;
    }
  }

  void onVehicleSelected(VehicleEntity vehicle) {
    driverOfferEntity.vehicle_id = vehicle.resource_id;
  }

  void _addMarker(String mkId, PlaceItemRes place) async {
    markers.remove(mkId);
    final String markerIdVal = mkId;
    print(place.address);
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(place.lat, place.lng),
      infoWindow: InfoWindow(title: place.name, snippet: place.address),
    );
    setState(() {
      markers[mkId] = marker;
    });
    _mapController.showMarkerInfoWindow(markerId);
  }

  void _moveCamera() {
    print("move camera: ");

    if (markers.values.length > 1) {
      var fromLatLng = markers["from_address"].position;
      var toLatLng = markers["to_address"].position;

      var sLat, sLng, nLat, nLng;
      if (fromLatLng.latitude <= toLatLng.latitude) {
        sLat = fromLatLng.latitude;
        nLat = toLatLng.latitude;
      } else {
        sLat = toLatLng.latitude;
        nLat = fromLatLng.latitude;
      }

      if (fromLatLng.longitude <= toLatLng.longitude) {
        sLng = fromLatLng.longitude;
        nLng = toLatLng.longitude;
      } else {
        sLng = toLatLng.longitude;
        nLng = fromLatLng.longitude;
      }

      LatLngBounds bounds = LatLngBounds(northeast: LatLng(nLat, nLng), southwest: LatLng(sLat, sLng));
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      _mapController.animateCamera(CameraUpdate.newLatLng(markers.values.elementAt(0).position));
    }
  }

  void _checkDrawPolyline() {
    if (markers.length > 1) {
      var from = markers["from_address"].position;
      var to = markers["to_address"].position;
      MapRepository.getStep(from.latitude, from.longitude, to.latitude, to.longitude).then((vl) {
        TripInfoRes infoRes = vl;
        _tripDistance = infoRes.distance;
        setState(() {});
        List<StepsRes> rs = infoRes.steps;
        List<LatLng> paths = new List();
        for (var t in rs) {
          paths.add(LatLng(t.startLocation.latitude, t.startLocation.longitude));
          paths.add(LatLng(t.endLocation.latitude, t.endLocation.longitude));
        }
        print(paths.first.latitude);
      });
      print(' steps are : ' + '$steps');
    }
  }
}

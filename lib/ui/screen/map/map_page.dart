import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:relax/data/model/driver_offer_entity.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/model/requestInfo.dart';
import 'package:relax/data/model/step_res.dart';
import 'package:relax/data/model/trip_info_res.dart';
import 'package:relax/data/model/verhicle_entity.dart';
import 'package:relax/data/repository/map_repository.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/map/shiper/ride_picker.dart';
import 'package:relax/ui/widget/app_bar.dart';
import 'package:relax/viewmodel/driver_model.dart';
import 'package:stacked/stacked.dart';
import 'home_menu.dart';

class MapPage extends StatefulWidget {
  static const mapKey = "AIzaSyAdH-Drq0svd8QQV_jUq7kmYjBPKNPYx4c";

  @override
  State<StatefulWidget> createState() => MapState();
}

class MapState extends State<MapPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _tripDistance = 0;
  final RequestInfo request = new RequestInfo();
  final Map<String, Marker> markers = <String, Marker>{};
  final String nextstep = 'weiter =>';
  int _polylineCount = 1;
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  GoogleMapController _mapController;
  final DriverOfferEntity driverOfferEntity = DriverOfferEntity();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DriverModel>.nonReactive(
      viewModelBuilder: () => DriverModel(),
      disposeViewModel: false,
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
                polylines: Set<Polyline>.of(_polylines.values),
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
            _scaffoldKey.currentState.showSnackBar(
              new SnackBar(
                content: new Text(
                  'Send data complete!',
                  style: TextStylesUtils.styleMedium20White,
                ),
              ),
            );
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
    var mkId = fromAddress ? "from_address" : "to_address";
    _addMarker(mkId, place);
    if (fromAddress) {
      driverOfferEntity.from_address = place.address;
      driverOfferEntity.from_lat = place.lat;
      driverOfferEntity.from_lon = place.lng;
    } else {
      driverOfferEntity.to_address = place.address;
      driverOfferEntity.to_lat = place.lat;
      driverOfferEntity.to_lon = place.lng;
    }
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
      _mapController.animateCamera(CameraUpdate.newLatLng(markers.values.elementAt(0).position));
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

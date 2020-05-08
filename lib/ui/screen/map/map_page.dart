import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:relax/data/model/driver_offer_entity.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/model/request_info_entity.dart';
import 'package:relax/data/model/trip_info_res.dart';
import 'package:relax/data/model/verhicle_entity.dart';
import 'package:relax/data/repository/map_repository.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/ui/screen/map/pickdata/ride_picker.dart';
import 'package:relax/ui/widget/app_bar.dart';
import 'package:relax/ui/widget/bottomsheet_widget.dart';
import 'package:relax/viewmodel/driver_model.dart';
import 'package:relax/viewmodel/home_model.dart';
import 'package:stacked/stacked.dart';

import 'home_menu.dart';
import 'pickdata/packaging_pickup.dart';

class MapPage extends StatefulWidget {
  static const mapKey = "AIzaSyAdH-Drq0svd8QQV_jUq7kmYjBPKNPYx4c";
  ROLE role;

  MapPage(this.role);

  @override
  State<StatefulWidget> createState() => MapState();
}

class MapState extends State<MapPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _tripDistance = 0;
  final Map<String, Marker> markers = <String, Marker>{};
  final String nextstep = 'weiter =>';
  int _polylineCount = 1;
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  List<LatLng> routeCoords = new List();
  GoogleMapController _mapController;
  final RequestInfo requestPool = new RequestInfo();
  final DriverOfferEntity driverOfferEntity = DriverOfferEntity();
  final GoogleMapPolyline _googleMapPolyline = GoogleMapPolyline(apiKey: "AIzaSyAdH-Drq0svd8QQV_jUq7kmYjBPKNPYx4c");

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
            title: S.of(context).appName,
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
              RidePicker(widget.role == ROLE.DRIVER, onPlaceSelected, onPackagingSelected, onTimeSelected, onVehicleSelected),
            ],
          ),
          drawer: Drawer(
            child: HomeMenu(),
          ),
          floatingActionButton: MyFloatingButton(widget.role, model, driverOfferEntity, requestPool),
        );
      },
    );
  }

  void onPackagingSelected(PackagingItem pack) {
    requestPool.packaging_kind = pack.name;
    print("${requestPool.packaging_kind}");
  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
    _addMarker(mkId, place);
    _moveCamera();
    _checkDrawPolyline();
    if (widget.role == ROLE.DRIVER) {
      if (fromAddress) {
        driverOfferEntity.from_address = place.address;
        driverOfferEntity.from_lat = place.lat;
        driverOfferEntity.from_lon = place.lng;
      } else {
        driverOfferEntity.to_address = place.address;
        driverOfferEntity.to_lat = place.lat;
        driverOfferEntity.to_lon = place.lng;
      }
    } else if (widget.role == ROLE.SHIPPER) {
      requestPool.client_Id = 0;
      requestPool.requestId = 1;
      requestPool.status = 0;
      requestPool.fahrer_Id = -1;
      requestPool.transportmittel_Id = 0; // 1 nicht begonnen, 2 begonnen, 3 beendet
      if (fromAddress) {
        requestPool.pickup_Address = markers["from_address"].infoWindow.snippet;
        requestPool.pickup_Lat = markers["from_address"].position.latitude;
        requestPool.pickup_Lon = markers["from_address"].position.longitude;
      } else {
        requestPool.drop_Address = markers["to_address"].infoWindow.snippet;
        requestPool.drop_Lat = markers["to_address"].position.latitude;
        requestPool.drop_Lon = markers["to_address"].position.longitude;
      }
      requestPool.pickup_Status = 1;
      requestPool.request_Status = -1;
      requestPool.weight = 0;
      requestPool.hight = 0;
      requestPool.width = 0;
      requestPool.length = 0;
      requestPool.distance = _tripDistance;
      requestPool.countOfparcels = 1;
    }
  }

  void onTimeSelected(DateTime time, bool fromAddress) {
    if (widget.role == ROLE.DRIVER) {
      if (fromAddress) {
        driverOfferEntity.from_workingtime = time;
      } else {
        driverOfferEntity.to_workingtime = time;
      }
    } else if (widget.role == ROLE.SHIPPER) {
      requestPool.pickup_Time = time;
    }
  }

  void onVehicleSelected(VehicleEntity vehicle) {
    driverOfferEntity.vehicle_id = vehicle.resource_id;
  }

  void _addMarker(String mkId, PlaceItemRes place) {
    markers.remove(mkId);
    final String markerIdVal = mkId;
    print(place.address);
    final MarkerId markerId = MarkerId(markerIdVal);
    setState(() {
      markers[mkId] = Marker(
        markerId: markerId,
        position: LatLng(place.lat, place.lng),
        infoWindow: InfoWindow(title: place.name, snippet: place.address),
      );
    });
  }

  void _moveCamera() {
    print("move camera: ");
    if (_mapController == null) return;
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
      //print('bounds==' + bounds.toString() + "markers=" + markers.values.elementAt(0).position.toString());
      Future.delayed(Duration(milliseconds: 200), () => _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, ScreenUtil.screenWidthDp * 0.12)));
    } else {
      //print("markers=" + markers.values.elementAt(0).position.toString());
      Future.delayed(Duration(milliseconds: 200), () => _mapController.animateCamera(CameraUpdate.newLatLng(markers.values.elementAt(0).position)));
    }
  }

  Future<void> _checkDrawPolyline() async {
    if (markers.length > 1) {
      var from = markers["from_address"].position;
      var to = markers["to_address"].position;
      routeCoords.clear();
      routeCoords = await _googleMapPolyline.getCoordinatesWithLocation(
          origin: LatLng(from.latitude, from.longitude), destination: LatLng(to.latitude, to.longitude), mode: RouteMode.driving);
      _addPolyline();
      MapRepository.getStep(from.latitude, from.longitude, to.latitude, to.longitude).then((v2) async {
        TripInfoRes infoRes = v2;
        _tripDistance = infoRes.distance.toDouble();
        print("distance is $_tripDistance");
      });
    }
  }

  _addPolyline() {
    print(routeCoords.map((e) => e.toString()));
    PolylineId id = PolylineId("poly$_polylineCount");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blueAccent,
        points: routeCoords,
        geodesic: true,
        jointType: JointType.round,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap,
        width: 5,
        onTap: () {});
    print("polyline=" + polyline.points.map((e) => e.toString()).toString());
    print("polyline=" + polyline.patterns.map((e) => e.toString()).toString());
    setState(() {
      _polylines[id] = polyline;
      _polylineCount++;
    });
  }
}

LatLngBounds boundsFromLatLngList(List<LatLng> list) {
  assert(list.isNotEmpty);
  double x0, x1, y0, y1;
  for (LatLng latLng in list) {
    if (x0 == null) {
      x0 = x1 = latLng.latitude;
      y0 = y1 = latLng.longitude;
    } else {
      if (latLng.latitude > x1) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1) y1 = latLng.longitude;
      if (latLng.longitude < y0) y0 = latLng.longitude;
    }
  }
  return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
}

class MyFloatingButton extends StatefulWidget {
  final DriverOfferEntity driverOfferEntity;
  final RequestInfo requestPool;
  final DriverModel model;
  final ROLE role;

  MyFloatingButton(this.role, this.model, this.driverOfferEntity, this.requestPool);

  @override
  _MyFloatingButtonState createState() => _MyFloatingButtonState();
}

class _MyFloatingButtonState extends State<MyFloatingButton> {
  bool _show = true;

  @override
  Widget build(BuildContext context) {
    return _show
        ? FloatingActionButton(
            onPressed: () async {
              if (widget.role == ROLE.DRIVER) {
                print('DRIVER==' + widget.driverOfferEntity.toString());
                await widget.model.addDriverOffer(widget.driverOfferEntity).then(
                  (value) {
                    if (value) {
                      print('Done');
                      widget.model.showErrorMessage(context, message: S.of(context).send_data_ok);
                      Navigator.of(context).pop();
                    } else {
                      widget.model.showErrorMessage(context);
                    }
                  },
                );
              } else if (widget.role == ROLE.SHIPPER) {
                print('SHIPPER==' + widget.requestPool.toString());
                var sheetController = showBottomSheet(
                  context: context,
                  builder: (context) => BottomSheetWidget(widget.model, widget.requestPool),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.white,
                );
                _showButton(false);
                sheetController.closed.then((value) {
                  _showButton(true);
                });
              }
            },
            child: Icon(Icons.send),
            backgroundColor: Colors.pink,
          )
        : Container();
  }

  void _showButton(bool value) {
    setState(() {
      _show = value;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/model/verhicle_entity.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/map/pickdata/ride_picker_page.dart';
import 'package:relax/ui/screen/widget/container_button.dart';
import 'package:relax/viewmodel/driver_model.dart';
import 'package:stacked/stacked.dart';
import 'basic_datetime.dart';
import 'packaging_pickup.dart';

class RidePicker extends StatefulWidget {
  final Function(PlaceItemRes, bool) onSelected;
  final Function(PackagingItem) onPacked;
  final Function(DateTime, bool) onSelectedTime;
  final Function(VehicleEntity) onSelectedVehicle;
  bool isDriver;

  RidePicker(this.isDriver, this.onSelected, this.onPacked, this.onSelectedTime, this.onSelectedVehicle);

  @override
  _RidePickerState createState() => _RidePickerState();
}

class _RidePickerState extends State<RidePicker> {
  PlaceItemRes fromAddress;
  PlaceItemRes toAddress;
  DateTime fromTime;
  DateTime toTime;
  List<DropdownMenuItem<VehicleEntity>> _dropDownMenuItems;
  VehicleEntity _currentVehicle;
  DateTime selectedTime;
  PackagingItem selectedPackaging;

  @override
  void initState() {
    super.initState();
    if (widget.isDriver) {
      if (_dropDownMenuItems != null) {
        _currentVehicle = _dropDownMenuItems[0].value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DriverModel>.nonReactive(
      viewModelBuilder: () => DriverModel(),
      disposeViewModel: false,
      onModelReady: (model) {},
      builder: (context, model, child) {
        if (_dropDownMenuItems == null && widget.isDriver) {
          model.getListVehicles().then((value) {
            _dropDownMenuItems = value;
            setState(() {});
          });
        }
        return Container(
          width: double.infinity,
          height: widget.isDriver ? 600.h : 400.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x88999999),
                  offset: Offset(0, 5),
                  blurRadius: 5.0,
                ),
              ]),
          child: Column(
            children: <Widget>[
              ContainerButton(
                isExpanded: true,
                isCenter: false,
                title: fromAddress == null ? "FromLocation" : fromAddress.name,
                textStyle: TextStylesUtils.styleRegular14BlackW400,
                cb: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RidePickerPage(fromAddress == null ? "" : fromAddress.name, (place, isFrom) {
                        widget.onSelected(place, isFrom);
                        fromAddress = place;
                        setState(() {});
                      }, true),
                    ),
                  );
                },
              ),
              Divider(),
              ContainerButton(
                isExpanded: true,
                isCenter: false,
                title: toAddress == null ? "ToLocation" : toAddress.name,
                textStyle: TextStylesUtils.styleRegular14BlackW400,
                cb: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RidePickerPage(toAddress == null ? '' : toAddress.name, (place, isFrom) {
                        widget.onSelected(place, isFrom);
                        toAddress = place;
                        setState(() {});
                      }, false),
                    ),
                  );
                },
              ),
              Divider(),
              buildWidgetRole()
            ],
          ),
        );
      },
    );
  }

  Widget buildWidgetRole() {
    if (widget.isDriver) {
      return Column(
        children: [
          ContainerButton(
            isExpanded: true,
            isCenter: false,
            title: fromTime == null ? "FromTime" : Constant.format.format(fromTime),
            textStyle: TextStylesUtils.styleRegular14BlackW400,
            cb: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyDateTimePage(fromTime == null ? DateTime.now() : fromTime, (datetime, isFrom) {
                    widget.onSelectedTime(datetime, isFrom);
                    fromTime = datetime;
                    setState(() {});
                  }, true),
                ),
              );
            },
          ),
          Divider(),
          ContainerButton(
            isExpanded: true,
            isCenter: false,
            title: toTime == null ? "ToTime" : Constant.format.format(toTime),
            textStyle: TextStylesUtils.styleRegular14BlackW400,
            cb: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyDateTimePage(toTime == null ? DateTime.now() : toTime, (datetime, isFrom) {
                    widget.onSelectedTime(datetime, isFrom);
                    toTime = datetime;
                    setState(() {});
                  }, false),
                ),
              );
            },
          ),
          Divider(),
          Container(
            padding: EdgeInsets.only(left: 50.w),
            alignment: Alignment.centerLeft,
            child: DropdownButton(
              hint: Text(
                'Selected Vehicle',
                style: TextStylesUtils.styleRegular12PinkishOrangeW600,
              ),
              value: _currentVehicle,
              items: _dropDownMenuItems,
              onChanged: (vehicle) {
                print("Selected city ${vehicle.toString()}, we are going to refresh the UI");
                setState(
                  () {
                    if (vehicle != null) {
                      _currentVehicle = vehicle;
                      widget.onSelectedVehicle(_currentVehicle);
                    }
                  },
                );
              },
            ),
          )
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PackagingPickup(
                      (_packaging) {
                        widget.onPacked(_packaging);
                        selectedPackaging = _packaging;
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: Text(
                        selectedPackaging == null ? "packaging" : selectedPackaging.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}

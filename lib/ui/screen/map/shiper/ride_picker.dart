import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/model/verhicle_entity.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/map/basic_datetime.dart';
import 'package:relax/ui/screen/map/shiper/ride_picker_page.dart';
import 'package:relax/ui/screen/widget/container_button.dart';
import 'package:relax/viewmodel/driver_model.dart';
import 'package:stacked/stacked.dart';

class RidePicker extends StatefulWidget {
  final Function(PlaceItemRes, bool) onSelected;
  final Function(DateTime, bool) onSelectedTime;
  final Function(VehicleEntity) onSelectedVehicle;

  RidePicker(this.onSelected, this.onSelectedTime, this.onSelectedVehicle);

  @override
  _RidePickerState createState() => _RidePickerState();
}

class _RidePickerState extends State<RidePicker> {
  PlaceItemRes fromAddress;
  PlaceItemRes toAddress;
  DateTime fromTime;
  DateTime toTime;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  List<DropdownMenuItem<VehicleEntity>> _dropDownMenuItems;
  VehicleEntity _currentVehicle;

  @override
  void initState() {
    super.initState();
    if (_dropDownMenuItems != null) {
      _currentVehicle = _dropDownMenuItems[0].value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DriverModel>.nonReactive(
      viewModelBuilder: () => DriverModel(),
      disposeViewModel: false,
      onModelReady: (model) {},
      builder: (context, model, child) {
        if (_dropDownMenuItems == null) {
          model.getListVehicles().then((value) {
            _dropDownMenuItems = value;
            setState(() {});
          });
        }
        return Container(
          width: double.infinity,
          height: 600.h,
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
              ContainerButton(
                isExpanded: true,
                isCenter: false,
                title: fromTime == null ? "FromTime" : format.format(fromTime),
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
                title: toTime == null ? "ToTime" : format.format(toTime),
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
          ),
        );
      },
    );
  }
}

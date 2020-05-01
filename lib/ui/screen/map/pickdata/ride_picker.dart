import 'package:flutter/material.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/model/verhicle_entity.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
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
  bool isDriver = false;

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
          height: widget.isDriver ? 650.h : 550.h,
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
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: <Widget>[
                ContainerButton(
                  isExpanded: true,
                  isCenter: false,
                  title: fromAddress == null ? S.of(context).FromLocation : fromAddress.name,
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
                  title: toAddress == null ? S.of(context).ToLocation : toAddress.name,
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
          ),
        );
      },
    );
  }

  Widget buildWidgetRole() {
    if (widget.isDriver) {
      return Container(
        width: double.infinity,
        height: 380.h,
        child: Column(
          children: [
            ContainerButton(
              isExpanded: true,
              isCenter: false,
              title: fromTime == null ? S.of(context).FromTime : Constant.format.format(fromTime),
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
              title: toTime == null ? S.of(context).ToTime : Constant.format.format(toTime),
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
                  S.of(context).vehicle,
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
    } else {
      return Container(
        width: double.infinity,
        height: 240.h,
        child: Column(
          children: [
            ContainerButton(
              isExpanded: true,
              isCenter: false,
              title: fromTime == null ? S.of(context).pick_time : Constant.format.format(fromTime),
              textStyle: TextStylesUtils.styleRegular14BlackW400,
              cb: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyDateTimePage(fromTime == null ? DateTime.now() : fromTime, (datetime, isFrom) {
                      widget.onSelectedTime(datetime, isFrom);
                      fromTime = datetime;
                      setState(() {});
                    }, false),
                  ),
                );
              },
            ),
            Divider(),
            InkWell(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 18.0,
                    backgroundColor: ColorsUtils.offWhite,
                    child: selectedPackaging != null
                        ? Image.asset(
                            selectedPackaging.assetsName,
                            height: 30,
                            width: 30,
                          )
                        : Container(),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Text(
                    selectedPackaging == null ? "packaging" : selectedPackaging.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStylesUtils.styleMedium18Black,
                  )
                ],
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PackagingPickup(
                    (_packaging) {
                      widget.onPacked(_packaging);
                      selectedPackaging = _packaging;
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

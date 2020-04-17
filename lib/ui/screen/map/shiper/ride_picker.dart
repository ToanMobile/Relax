import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/ui/screen/map/basic_datetime.dart';
import 'package:relax/ui/screen/map/shiper/ride_picker_page.dart';
import 'package:relax/ui/screen/widget/container_button.dart';

class RidePicker extends StatefulWidget {
  final Function(PlaceItemRes, bool) onSelected;
  final Function(DateTime, bool) onSelectedTime;

  RidePicker(this.onSelected, this.onSelectedTime);

  @override
  _RidePickerState createState() => _RidePickerState();
}

class _RidePickerState extends State<RidePicker> {
  PlaceItemRes fromAddress;
  PlaceItemRes toAddress;
  DateTime fromTime;
  DateTime toTime;
  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400.h,
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
        ],
      ),
    );
  }
}

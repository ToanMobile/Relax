import 'package:flutter/material.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/ui/screen/map/shiper/ride_picker_page.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/ui/screen/widget/container_button.dart';
import '../packaging_pickup.dart';

class RidePicker extends StatefulWidget {
  final Function(PlaceItemRes, bool) onSelected;

  RidePicker(this.onSelected, this.onPackagingselected);

  final Function(PackagingItem) onPackagingselected;

  @override
  _RidePickerState createState() => _RidePickerState();
}

class _RidePickerState extends State<RidePicker> {
  PlaceItemRes fromAddress;
  PlaceItemRes toAddress;
  PackagingItem selectedpackaging;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250.h,
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
            title: fromAddress == null ? "From" : fromAddress.name,
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
            title: toAddress == null ? "To" : toAddress.name,
            cb: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RidePickerPage(toAddress == null ? "" : toAddress.name, (place, isFrom) {
                    widget.onSelected(place, isFrom);
                    toAddress = place;
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

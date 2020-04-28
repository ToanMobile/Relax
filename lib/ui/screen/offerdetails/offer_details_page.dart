import 'package:flutter/material.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/data/model/offer_info_entity.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/viewmodel/home_model.dart';
import 'package:stacked/stacked.dart';

class OfferDetailsPage extends StatefulWidget {
  final OfferInfoEntity offerInfoEntity;

  OfferDetailsPage({@required this.offerInfoEntity});

  @override
  State<StatefulWidget> createState() => OfferDetailsState();
}

class OfferDetailsState extends State<OfferDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.white,
      body: ViewModelBuilder<HomeModel>.reactive(
        viewModelBuilder: () => HomeModel(),
        onModelReady: (model) => model.getListOffer(),
        disposeViewModel: false,
        builder: (context, model, child) {
          return Container(
            margin: EdgeInsets.all(60.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: ColorsUtils.lightPink,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.4),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(60.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildTextUserName(model.getName),
                  SizedBox(
                    height: 20.h,
                  ),
                  buildTextRole(buildIconRole(model.getRole)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('Email: ${model.user.email}', style: TextStylesUtils.styleMedium20CoalGreyW600),
                  Text('Customer Name: ${widget.offerInfoEntity.guest_Name}', style: TextStylesUtils.styleMedium20CoalGreyW600),
                  Text('Customer Address: ${widget.offerInfoEntity.guest_Address}', style: TextStylesUtils.styleMedium20CoalGreyW600),
                  Text('Customer Phone: ${widget.offerInfoEntity.guest_Phone}', style: TextStylesUtils.styleMedium20CoalGreyW600),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      model.getRole == Constant.role_driver
                          ? 'From Address: ${widget.offerInfoEntity.from_address}'
                          : 'Pick Address: ${widget.offerInfoEntity.pickup_Address}',
                      style: TextStylesUtils.styleMedium20CoalGreyW600),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      model.getRole == Constant.role_driver
                          ? 'To Address: ${widget.offerInfoEntity.to_address}'
                          : 'Drop Address: ${widget.offerInfoEntity.drop_Address}',
                      style: TextStylesUtils.styleMedium20CoalGreyW600),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      model.getRole == Constant.role_driver
                          ? 'From Time: ${widget.offerInfoEntity.from_workingtime}'
                          : 'Pick Time: ${widget.offerInfoEntity.pickup_Time}',
                      style: TextStylesUtils.styleMedium20CoalGreyW600),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(model.getRole == Constant.role_driver ? 'To Time: ${widget.offerInfoEntity.to_workingtime}' : 'Receiving Time: 00-00-00',
                      style: TextStylesUtils.styleMedium20CoalGreyW600),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTextUserName(String name) => Container(
        alignment: Alignment.bottomCenter,
        width: ScreenUtil.screenWidthDp,
        height: ScreenUtil.screenHeightDp * 0.13,
        child: Text('Name: $name', textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20CoalGreyW600),
      );

  Widget buildTextRole(String role) => Container(
        alignment: Alignment.center,
        width: ScreenUtil.screenWidthDp,
        child: Text('Role: $role', textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20CoalGreyW600),
      );

  String buildIconRole(int role) {
    if (role == Constant.role_shipper) {
      return 'Shipper';
    } else if (role == Constant.role_driver) {
      return 'Driver';
    } else if (role == Constant.role_shipper_driver) {
      return 'Shipper & Driver';
    } else {
      return 'Unknown';
    }
  }
}

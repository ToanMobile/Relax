import 'package:flutter/material.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/data/model/offer_info_entity.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/widget/app_bar.dart';
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
    return ViewModelBuilder<HomeModel>.reactive(
      viewModelBuilder: () => HomeModel(),
      onModelReady: (model) => model.getListOffer(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorsUtils.white,
          appBar: AppBarIcon.back(
            color: ColorsUtils.white,
          ).build(context),
          body: Container(
            margin: EdgeInsets.only(left: 60.w, right: 60.w, bottom: 60.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: checkIsDriver() ? ColorsUtils.bg_driver : ColorsUtils.bg_shipper,
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
              padding: EdgeInsets.only(left: 60.w, right: 60.w),
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
                  Text(S.of(context).login_email + ': ${model.user.email}', style: TextStylesUtils.styleMedium20CoalGreyW600),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      checkIsDriver()
                          ? S.of(context).FromLocation + ': ${widget.offerInfoEntity.from_address}'
                          : S.of(context).pick_address + ': ${widget.offerInfoEntity.pickup_Address}',
                      style: TextStylesUtils.styleMedium20CoalGreyW600),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      checkIsDriver()
                          ? S.of(context).ToLocation + ': ${widget.offerInfoEntity.to_address}'
                          : S.of(context).drop_address + ': ${widget.offerInfoEntity.drop_Address}',
                      style: TextStylesUtils.styleMedium20CoalGreyW600),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                      checkIsDriver()
                          ? S.of(context).FromTime + ': ${widget.offerInfoEntity.from_workingtime}'
                          : S.of(context).pick_time + ': ${widget.offerInfoEntity.pickup_Time}',
                      style: TextStylesUtils.styleMedium20CoalGreyW600),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(checkIsDriver() ? S.of(context).ToTime + ': ${widget.offerInfoEntity.to_workingtime}' : '',
                      style: TextStylesUtils.styleMedium20CoalGreyW600),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool checkIsDriver() => widget.offerInfoEntity.uid != null;

  Widget buildTextUserName(String name) => Container(
        alignment: Alignment.bottomCenter,
        width: ScreenUtil.screenWidthDp,
        height: ScreenUtil.screenHeightDp * 0.13,
        child: Text(S.of(context).login_username + ': $name', textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20CoalGreyW600),
      );

  Widget buildTextRole(String role) => Container(
        alignment: Alignment.center,
        width: ScreenUtil.screenWidthDp,
        child: Text(S.of(context).role + ': $role', textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20CoalGreyW600),
      );

  String buildIconRole(int role) {
    if (role == Constant.role_shipper) {
      return S.of(context).shipper;
    } else if (role == Constant.role_driver) {
      return S.of(context).driver;
    } else if (role == Constant.role_shipper_driver) {
      return S.of(context).shipper_driver;
    } else {
      return 'Unknown';
    }
  }
}

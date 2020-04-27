import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/data/model/driver_offer_entity.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/widget/button_progress_indicator.dart';
import 'package:relax/ui/widget/filled_round_button.dart';
import 'package:relax/ui/widget/text_input_search.dart';
import 'package:relax/viewmodel/home_model.dart';
import 'package:stacked/stacked.dart';

class ListOfferPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListOfferState();
}

class ListOfferState extends State<ListOfferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.offWhite,
      body: ViewModelBuilder<HomeModel>.reactive(
        viewModelBuilder: () => HomeModel(),
        onModelReady: (model) => model.getListOffer(),
        disposeViewModel: false,
        builder: (context, model, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTextUserName(model.getName),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildLogOut(model),
                  SizedBox(
                    width: 50.w,
                  ),
                  buildCreateOffer(model),
                ],
              ),
              buildListUser(model)
            ],
          );
        },
      ),
    );
  }

  Widget buildTextUserName(String name) => Container(
        alignment: Alignment.bottomCenter,
        width: ScreenUtil.screenWidthDp,
        height: ScreenUtil.screenHeightDp * 0.13,
        child: Text(name, textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20CoalGreyW600),
      );

  Widget buildTextSearch() => Container(
        width: ScreenUtil.screenWidthDp,
        child: Text(S.of(context).home_search, textAlign: TextAlign.center, style: TextStylesUtils.styleRegular14BlackW400),
      );

  Widget buildSearchView() => TextInputSearch(
        validateErrMsg: "",
      );

  Widget buildLogOut(HomeModel model) => Center(
        child: Container(
          width: 300.w,
          height: 130.h,
          child: FilledRoundButton.withGradient(
            radius: 10,
            gradientColor: Constant.gradient_WaterMelon_Melon,
            text: Text(S.of(context).logout, textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20White),
            cb: () async {
              await model.logout();
              Navigator.pushNamed(context, RouteName.login);
            },
          ),
        ),
      );

  Widget buildCreateOffer(HomeModel model) => Center(
        child: Container(
          width: 300.w,
          height: 130.h,
          child: FilledRoundButton.withGradient(
            radius: 10,
            gradientColor: Constant.gradient_WaterMelon_Melon,
            text: Text(S.of(context).createNew, textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20White),
            cb: () async {
              SchedulerBinding.instance.addPostFrameCallback((_) {});
              await model.checkRegisterDriver().then((value) {
                switch (value) {
                  case DataLogin.CAPTURE:
                    Navigator.popAndPushNamed(context, RouteName.capture);
                    break;
                  case DataLogin.DRIVER:
                    Navigator.popAndPushNamed(context, RouteName.driver);
                    break;
                  case DataLogin.SHIPPER:
                    Navigator.popAndPushNamed(context, RouteName.shipper);
                    break;
                  case DataLogin.DRIVER_SHIPPER:
                    Navigator.popAndPushNamed(context, RouteName.driver);
                    break;
                  case DataLogin.ERROR:
                    break;
                }
              });
            },
          ),
        ),
      );

  Widget buildListUser(HomeModel model) {
    List<DriverOfferEntity> listOffer = model.listOffer;
    Widget child = model.busy
        ? Container(
            height: 150.h,
            child: Center(
              child: ButtonProgressIndicator(),
            ),
          )
        : Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              width: ScreenUtil.screenWidthDp,
              height: 1200.h,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: listOffer != null ? listOffer.length : 0,
                itemBuilder: (context, index) {
                  if (listOffer.length > 0) {
                    return InkWell(
                      child: buildListItem(listOffer, index, model.getRole),
                      onTap: () => Navigator.popAndPushNamed(context, RouteName.offer_details),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          );
    return child;
  }

  Widget buildListItem(List<DriverOfferEntity> listOffer, int index, int role) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 480.h,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: ColorsUtils.coralPink,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Flexible(
                    child: Text(
                      listOffer[index].from_address ?? "",
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: TextStylesUtils.styleRegular14BlackW400,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timer,
                    color: ColorsUtils.coralPink,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    listOffer[index].from_workingtime != null ? Constant.format.format(listOffer[index].from_workingtime) : "00-00-00",
                    textAlign: TextAlign.center,
                    style: TextStylesUtils.styleRegular14BlackW400,
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_off,
                    color: ColorsUtils.coralPink,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Flexible(
                    child: Text(
                      listOffer[index].to_address ?? "",
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: TextStylesUtils.styleRegular14BlackW400,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timer_off,
                    color: ColorsUtils.coralPink,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    listOffer[index].to_workingtime != null ? Constant.format.format(listOffer[index].to_workingtime) : "00-00-00",
                    textAlign: TextAlign.center,
                    style: TextStylesUtils.styleRegular14BlackW400,
                  ),
                ],
              ),
              buildIconRole(role),
            ],
          )
        ],
      ),
    );
  }

  Widget buildIconRole(int role) {
    if (role == Constant.role_shipper) {
      return Text(
        'Shipper',
        style: TextStylesUtils.styleMedium20Black,
      );
    } else if (role == Constant.role_driver) {
      return Text(
        'Driver',
        style: TextStylesUtils.styleMedium20Black,
      );
    } else if (role == Constant.role_shipper_driver) {
      return Text(
        'Shipper & Driver',
        style: TextStylesUtils.styleMedium20Black,
      );
    } else {
      return Text(
        'Unknown',
        style: TextStylesUtils.styleMedium20Black,
      );
    }
  }
}

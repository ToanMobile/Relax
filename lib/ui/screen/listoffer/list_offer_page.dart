import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/data/model/offer_info_entity.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/provider/view_state_widget.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/widget/app_bar.dart';
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
    return ViewModelBuilder<HomeModel>.reactive(
      viewModelBuilder: () => HomeModel(),
      onModelReady: (model) async {
        await model.checkRegisterDriver();
        await model.getListOffer();
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorsUtils.white,
          appBar: AppBarIcon.back(
            color: ColorsUtils.white,
            title: S.of(context).list_offer,
          ).build(context),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildLogOut(model),
                  buildRole(model),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              buildListUser(model)
            ],
          ),
        );
      },
    );
  }

  Widget buildRole(HomeModel model) {
    Widget child;
    if (model.roleCheck == ROLE.DRIVER_SHIPPER) {
      child = Row(children: [
        SizedBox(
          width: 30.w,
        ),
        buildCreateRequest(model),
        SizedBox(
          width: 30.w,
        ),
        buildCreateOffer(model),
      ]);
    } else if (model.roleCheck == ROLE.SHIPPER) {
      child = Row(
        children: [
          SizedBox(
            width: 30.w,
          ),
          buildCreateRequest(model)
        ],
      );
    } else if (model.roleCheck == ROLE.DRIVER || (model.roleCheck == ROLE.CAPTURE && model.getRole != Constant.role_shipper_driver)) {
      child = Row(
        children: [
          SizedBox(
            width: 30.w,
          ),
          buildCreateOffer(model),
        ],
      );
    } else {
      child = Container();
    }
    return child;
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
          width: 320.w,
          height: 130.h,
          child: FilledRoundButton.withGradient(
            radius: 10,
            gradientColor: Constant.gradient_WaterMelon_Melon,
            text: Text(S.of(context).logout, textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20White),
            cb: () async {
              await model.logout();
              Navigator.pushNamedAndRemoveUntil(context, RouteName.login, (Route<dynamic> route) => false);
            },
          ),
        ),
      );

  Widget buildCreateOffer(HomeModel model) => Center(
        child: Container(
          width: 320.w,
          height: 130.h,
          child: FilledRoundButton.withGradient(
            radius: 10,
            gradientColor: Constant.gradient_WaterMelon_Melon,
            text: Text(S.of(context).createOffer, textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20White),
            cb: () {
              actionCreate(model, true);
            },
          ),
        ),
      );

  Widget buildCreateRequest(HomeModel model) => Center(
        child: Container(
          width: 320.w,
          height: 130.h,
          child: FilledRoundButton.withGradient(
            radius: 10,
            gradientColor: Constant.gradient_WaterMelon_Melon,
            text: Text(S.of(context).createRequest, textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20White),
            cb: () {
              actionCreate(model, false);
            },
          ),
        ),
      );

  Future actionCreate(HomeModel model, bool isDriver) async {
    SchedulerBinding.instance.addPostFrameCallback((_) {});
    if (model.roleCheck == ROLE.CAPTURE) {
      Navigator.pushNamed(context, RouteName.capture);
    } else if (isDriver) {
      Navigator.pushNamed(context, RouteName.driver);
    } else {
      Navigator.pushNamed(context, RouteName.shipper);
    }
  }

  selectShipperOrDriver(BuildContext context) async {
    final _select = CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(S.of(context).shipper),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoActionSheetAction(
          child: Container(child: Text(S.of(context).driver)),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.popAndPushNamed(context, RouteName.driver);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(child: Text(S.of(context).actionCancel), onPressed: () => Navigator.of(context).pop()),
    );
    showCupertinoModalPopup(context: context, builder: (context) => _select);
  }

  Widget buildListUser(HomeModel model) {
    List<OfferInfoEntity> listOffer = model.listOffer;
    Widget child = model.busy
        ? Container(
            height: 150.h,
            child: Center(
              child: ButtonProgressIndicator(
                color: ColorsUtils.fadedRed,
              ),
            ),
          )
        : Expanded(
            flex: 1,
            child: listOffer != null && listOffer.length > 0
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 32.w),
                    width: ScreenUtil.screenWidthDp,
                    height: 1200.h,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: listOffer != null ? listOffer.length : 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: buildListItem(listOffer, index, model.getRole),
                          onTap: () => Navigator.pushNamed(context, RouteName.offer_details, arguments: listOffer[index]),
                        );
                      },
                    ),
                  )
                : ViewStateEmptyWidget(
                    onPressed: () {
                      actionCreate(model, model.getRole == Constant.role_driver);
                    },
                  ),
          );
    return child;
  }

  Widget buildListItem(List<OfferInfoEntity> listOffer, int index, int role) {
    bool isDriver = listOffer[index].uid != null ?? false;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: isDriver ? ColorsUtils.bg_driver : ColorsUtils.bg_shipper,
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
      width: double.infinity,
      height: 140,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Column(
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
                  isDriver ? listOffer[index].from_address ?? "" : listOffer[index].pickup_Address ?? "",
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                isDriver
                    ? listOffer[index].from_workingtime != null ? Constant.format.format(listOffer[index].from_workingtime) : "00-00-00"
                    : listOffer[index].pickup_Time != null ? Constant.format.format(listOffer[index].pickup_Time) : "00-00-00",
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
                  isDriver ? listOffer[index].to_address ?? "" : listOffer[index].drop_Address ?? "",
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
        ],
      ),
    );
  }
}

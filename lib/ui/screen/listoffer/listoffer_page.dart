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
import 'package:relax/viewmodel/login_model.dart';
import 'package:relax/viewmodel/home_model.dart';
import 'package:stacked/stacked.dart';

class ListOfferPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListOfferState();
}

class ListOfferState extends State<ListOfferPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
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
              buildLogOut(model),
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
                itemCount: listOffer.length ?? 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: buildListItem(listOffer, index),
                    onTap: () async {
                      SchedulerBinding.instance.addPostFrameCallback((_) {});
                      await model.checkRegisterDriver().then((value) {
                        if (value == DataLogin.CAPTURE) {
                          Navigator.popAndPushNamed(context, RouteName.capture);
                        } else {
                          Navigator.popAndPushNamed(context, RouteName.map);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          );
    return child;
  }

  Widget buildListItem(List<DriverOfferEntity> listOffer, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 350.h,
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
                      listOffer[index].from_address.toString(),
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
                    Constant.format.format(listOffer[index].from_workingtime),
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
                      listOffer[index].to_address.toString(),
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
                    Constant.format.format(listOffer[index].to_workingtime),
                    textAlign: TextAlign.center,
                    style: TextStylesUtils.styleRegular14BlackW400,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

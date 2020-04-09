import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/repository/login_repository.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/widget/filled_round_button.dart';
import 'package:relax/ui/widget/text_input_search.dart';
import 'package:relax/viewmodel/user_model.dart';

enum View { TOP, BOTTOM }

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
        backgroundColor: ColorsUtils.offWhite,
        body: ViewModelProvider<UserModel>.withConsumer(
          viewModel: UserModel(),
          onModelReady: (model) {},
          builder: (context, model, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildTextUserName(model.getName),
                SizedBox(
                  height: 20.h,
                ),
                buildTextSearch(),
                SizedBox(
                  height: 40.h,
                ),
                buildSearchView(),
                SizedBox(
                  height: 20.h,
                ),
                buildLogOut(),
                buildListUser(model.listUser)
              ],
            );
          },
        ));
  }

  Widget buildTextUserName(String name) =>
      Container(
        alignment: Alignment.bottomCenter,
        width: ScreenUtil.screenWidthDp,
        height: ScreenUtil.screenHeightDp * 0.13,
        child: Text(name, textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20CoalGreyW600),
      );

  Widget buildTextSearch() =>
      Container(
        width: ScreenUtil.screenWidthDp,
        child: Text(S
            .of(context)
            .home_search, textAlign: TextAlign.center, style: TextStylesUtils.styleRegular14BlackW400),
      );

  Widget buildSearchView() =>
      TextInputSearch(
        validateErrMsg: "",
      );

  Widget buildLogOut() =>
      Center(
        child: Container(
          width: 300.w,
          height: 130.h,
          child: FilledRoundButton.withGradient(
            radius: 10,
            gradientColor: Constant.gradient_WaterMelon_Melon,
            text: Text(S
                .of(context)
                .logout, textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20White),
            cb: () async {
              await LoginRepository.logout();
              Navigator.pushNamed(context, RouteName.login);
            },
          ),
        ),
      );

  Widget buildListUser(List<LoginEntity> listUser) {
    print(listUser);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      width: ScreenUtil.screenWidthDp,
      height: 1200.h,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemExtent: 200.h,
        itemCount: listUser.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 12.w),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  listUser[index].name??"",
                  textAlign: TextAlign.center,
                  style: TextStylesUtils.styleRegular14BlackW400,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      listUser[index].address.toString(),
                      textAlign: TextAlign.center,
                      style: TextStylesUtils.styleMedium18Black,
                    ),
                    Text(
                      listUser[index].role.toString(),
                      textAlign: TextAlign.center,
                      style: TextStylesUtils.styleRegular14BlackW400,
                    ),
                    Text(
                      listUser[index].tel.toString(),
                      textAlign: TextAlign.center,
                      style: TextStylesUtils.styleRegular14BlackW400,
                    )
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: ColorsUtils.coral),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          );
        },
      ),
    );
  }
}

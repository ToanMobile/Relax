import 'package:relax/config/router_manger.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/widget/container_button_border.dart';
import 'package:relax/ui/screen/widget/parental_button.dart';
import 'package:flutter/material.dart';

class ParentalControlPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ParentalControlState();
}

class ParentalControlState extends State<ParentalControlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsUtils.background,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTitle(),
              SizedBox(
                height: 30.h,
              ),
              buildTitleContent(),
              SizedBox(
                height: 30.h,
              ),
              buildListParental(),
              SizedBox(
                height: 50.h,
              ),
              Container(
                width: 800.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ContainerButtonBorder(
                      title: S.of(context).parentalControlDone,
                      bgColor: ColorsUtils.background,
                      bgColorFocus: ColorsUtils.menuSelect,
                      isCenter: true,
                      cb: () {
                        Navigator.pushNamed(context, RouteName.parental);
                      },
                    ),
                    ContainerButtonBorder(
                      title: S.of(context).parentalControlChangePin,
                      bgColor: ColorsUtils.background,
                      bgColorFocus: ColorsUtils.menuSelect,
                      isCenter: true,
                      cb: () {
                        Navigator.pushNamed(context, RouteName.parental);
                      },
                    ),
                    ContainerButtonBorder(
                      title: S.of(context).parentalControlResetPin,
                      bgColor: ColorsUtils.background,
                      bgColorFocus: ColorsUtils.menuSelect,
                      isCenter: true,
                      cb: () {
                        Navigator.pushNamed(context, RouteName.parental);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  final listParental = ["7+", "13+", "18+", "22+"];

  Widget buildTitle() => Text(S.of(context).parentalControlTitle, style: TextStylesUtils().styleMedium30White);

  Widget buildTitleContent() => Text(S.of(context).parentalPc, style: TextStylesUtils().styleMedium20White);

  Widget buildListParental() => Container(
        height: 800.h,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: listParental.length,
            itemBuilder: (context, position) {
              return ContainerParental(
                title: listParental[position].toUpperCase(),
                bgColor: ColorsUtils.menuCategory,
                bgColorFocus: ColorsUtils.menuSelect,
                textStyle: TextStylesUtils().styleMedium18Black,
                textStyleFocus: TextStylesUtils().styleMedium18White,
              );
            }),
      );
}

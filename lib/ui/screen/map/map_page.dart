import 'package:relax/config/router_manger.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/widget/container_button.dart';
import 'package:flutter/material.dart';

enum View { TOP, BOTTOM }

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapState();
}

class MapState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: ColorsUtils.dark,
      body: Container(
        child: buildVast(),
      ),
    );
  }

  Widget buildWeather() => Expanded(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorsUtils.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(ImagesUtils.iconLanding),
                width: 600.w,
                height: 250.h,
              ),
              SizedBox(
                height: 100.h,
              ),
              Text(
                "4:51 pm  | Tuesday, April 07th, 2020 | 89F",
                style: TextStylesUtils().styleMedium20White,
              ),
            ],
          ),
        ),
        flex: 1,
      );

  Widget buildVast() => Expanded(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorsUtils.black,
        ),
        flex: 1,
      );
}

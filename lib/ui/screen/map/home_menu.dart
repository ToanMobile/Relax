import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/lib/screenutils/size_extension.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: double.infinity,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ListTile(
            leading: SvgPicture.asset(ImagesUtils.iconIdentity),
            title: Text(
              "My Profile",
              style: TextStylesUtils.styleMedium18Black,
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(ImagesUtils.iconHistory),
            title: Text(
              "Show History",
              style: TextStylesUtils.styleMedium18Black,
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              ImagesUtils.iconPercent,
              height: 24.0,
              width: 24.0,
              allowDrawingOutsideViewBox: true,
            ),
            title: Text(
              "Billing",
              style: TextStylesUtils.styleMedium18Black,
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(ImagesUtils.iconNotification),
            title: Text(
              "Notifications",
              style: TextStylesUtils.styleMedium18Black,
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(ImagesUtils.iconHelp),
            title: Text(
              "Help & Supports",
              style: TextStylesUtils.styleMedium18Black,
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(ImagesUtils.iconExit),
            title: Text(
              "Logout",
              style: TextStylesUtils.styleMedium18Black,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';

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
            leading: Icon(Icons.home),
            title: Text(
              S.of(context).tab_home,
              style: TextStylesUtils.styleMedium18Black,
            ),
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, RouteName.home, (Route<dynamic> route) => false),
          ),
          ListTile(
            leading: SvgPicture.asset(ImagesUtils.iconIdentity),
            title: Text(
              S.of(context).Profile,
              style: TextStylesUtils.styleMedium18Black,
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(ImagesUtils.iconHistory),
            title: Text(
              S.of(context).History,
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
              S.of(context).Billing,
              style: TextStylesUtils.styleMedium18Black,
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(ImagesUtils.iconNotification),
            title: Text(
              S.of(context).Notification,
              style: TextStylesUtils.styleMedium18Black,
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(ImagesUtils.iconHelp),
            title: Text(
              S.of(context).Help_Supports,
              style: TextStylesUtils.styleMedium18Black,
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(ImagesUtils.iconExit),
            title: Text(
              S.of(context).Logout,
              style: TextStylesUtils.styleMedium18Black,
            ),
          )
        ],
      ),
    );
  }
}

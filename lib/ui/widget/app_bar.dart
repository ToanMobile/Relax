import 'package:flutter/material.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/text_styles.dart';

enum IconType { BACK, CLOSE, DRAWER }

class AppBarIcon extends StatelessWidget {
  final IconType icon;
  final String title;
  final bool isOnlyIcon;
  final Color color;
  final bool isCenter;
  final VoidCallback cb;

  AppBarIcon.back({this.title = '', this.isOnlyIcon = false, this.color = ColorsUtils.pale, this.isCenter = true, this.cb})
      : this.icon = IconType.BACK;

  AppBarIcon.close({this.title = '', this.isOnlyIcon = false, this.color = ColorsUtils.pale, this.isCenter = true, this.cb})
      : this.icon = IconType.CLOSE;

  AppBarIcon.drawer({this.title = '', this.isOnlyIcon = false, this.color = ColorsUtils.pale, this.isCenter = true, this.cb})
      : this.icon = IconType.DRAWER;

  @override
  Widget build(BuildContext context) {
    if (this.icon == IconType.BACK) {
      if (this.isOnlyIcon) {
        return buildIconButtonBack(context);
      }
      if (this.title != '') {
        return buildAppBarBackTitle(context, this.title);
      } else {
        return buildAppBarBack(context);
      }
    } else if (this.icon == IconType.DRAWER) {
      return buildAppBarDrawerTitle(context, this.title);
    }
    if (this.isOnlyIcon) {
      return buildIconButtonClose(context);
    }
    if (this.title != '') {
      return buildAppBarCloseTitle(context, this.title);
    } else {
      return buildAppBarClose(context);
    }
  }

  Widget buildIconButtonBack(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.keyboard_backspace,
        color: ColorsUtils.black,
        size: 90.w,
      ),
    );
  }

  Widget buildIconButtonClose(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.close,
        color: ColorsUtils.black,
        size: 90.w,
      ),
    );
  }

  Widget buildIconButtonDrawer(BuildContext context) {
    return IconButton(
      onPressed: cb == null ? () => {} : cb,
      icon: Icon(
        Icons.menu,
        color: ColorsUtils.black,
        size: 90.w,
      ),
    );
  }

  AppBar buildAppBarBack(BuildContext context) {
    return AppBar(
      leading: buildIconButtonBack(context),
      backgroundColor: this.color,
      elevation: 0.0,
    );
  }

  AppBar buildAppBarBackTitle(BuildContext context, String title) {
    return AppBar(
      leading: buildIconButtonBack(context),
      backgroundColor: this.color,
      elevation: 0.0,
      title: buildAlignAppBar(title),
    );
  }

  AppBar buildAppBarClose(BuildContext context) {
    return AppBar(
      leading: buildIconButtonClose(context),
      backgroundColor: this.color,
      elevation: 0.0,
    );
  }

  AppBar buildAppBarCloseTitle(BuildContext context, String title) {
    return AppBar(
      leading: buildIconButtonClose(context),
      backgroundColor: this.color,
      elevation: 0.0,
      title: buildAlignAppBar(title),
    );
  }

  AppBar buildAppBarDrawerTitle(BuildContext context, String title) {
    return AppBar(
      centerTitle: true,
      leading: buildIconButtonDrawer(context),
      backgroundColor: this.color,
      elevation: 0.0,
      title: buildAlignAppBar(title),
    );
  }

  Widget buildAlignAppBar(String title) {
    return Text(title, style: TextStylesUtils.styleMedium20Black);
  }
}

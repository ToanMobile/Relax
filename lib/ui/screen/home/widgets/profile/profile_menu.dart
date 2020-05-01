import 'package:relax/generated/l10n.dart';

import '../../utils/constant.dart';
import '../../widgets/profile/menu_item.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        MenuItem(
          menu: ProfileModel(
            title: S.of(context).Address,
            subTitle: S.of(context).Address_content,
            iconColor: profile_info_address,
            icon: Icons.location_on,
          ),
        ),
        MenuItem(
          menu: ProfileModel(
            title: S.of(context).Privacy,
            subTitle: S.of(context).Privacy__content,
            iconColor: profile_info_privacy,
            icon: Icons.lock,
          ),
        ),
        MenuItem(
          menu: ProfileModel(
            title: S.of(context).General,
            subTitle: S.of(context).General__content,
            iconColor: profile_info_general,
            icon: Icons.layers,
          ),
        ),
        MenuItem(
          menu: ProfileModel(
            title: S.of(context).Notification,
            subTitle: S.of(context).Notification__content,
            iconColor: profile_info_notification,
            icon: Icons.notifications,
          ),
        ),
      ],
    );
  }
}

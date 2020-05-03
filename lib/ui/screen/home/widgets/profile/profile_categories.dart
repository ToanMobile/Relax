import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:relax/generated/l10n.dart';

import '../../utils/constant.dart';
import '../../widgets/profile/category.dart';

class ProfileCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Category(
            catg: Catg(name: S.of(context).Wallet, icon: Icons.account_balance_wallet, number: 0),
          ),
          Category(
            catg: Catg(name: S.of(context).Delivery, icon: Icons.directions_car, number: 0),
          ),
          Category(
            catg: Catg(name: S.of(context).Message, icon: Icons.message, number: 0),
          ),
          Category(
            catg: Catg(name: S.of(context).Service, icon: Icons.security, number: 0),
          )
        ],
      ),
    );
  }
}

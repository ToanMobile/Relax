import 'widgets/profile/profile_categories.dart';
import 'widgets/profile/profile_detail.dart';
import 'widgets/profile/profile_menu.dart';
import 'widgets/title_large.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 30.0,
        ),
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TitleLarge(
              title: 'Relax',
            ),
            SizedBox(
              height: 20.0,
            ),
            ProfileDetail(),
            SizedBox(
              height: 30.0,
            ),
            ProfileCategories(),
            SizedBox(
              height: 30.0,
            ),
            Flexible(child: ProfileMenu()),
          ],
        ),
      ),
    );
  }
}

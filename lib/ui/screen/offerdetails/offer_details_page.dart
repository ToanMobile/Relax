import 'package:flutter/material.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/viewmodel/home_model.dart';
import 'package:stacked/stacked.dart';

class OfferDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OfferDetailsState();
}

class OfferDetailsState extends State<OfferDetailsPage> {
  @override
  Widget build(BuildContext context) {
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
              buildIconRole(model.getRole),
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

  Widget buildIconRole(int role) {
    if (role == 0) {
      return Text(
        'Shipper',
        style: TextStylesUtils.styleMedium20Black,
      );
    } else if (role == 1) {
      return Text(
        'Driver',
        style: TextStylesUtils.styleMedium20Black,
      );
    } else if (role == 2) {
      return Text(
        'Shipper & Driver',
        style: TextStylesUtils.styleMedium20Black,
      );
    } else {
      return Text(
        'Unknown',
        style: TextStylesUtils.styleMedium20Black,
      );
    }
  }
}

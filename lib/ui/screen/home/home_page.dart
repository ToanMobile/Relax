import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
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
              buildListSuggest()
            ],
          );
        },
      ),
    );
  }

  Widget buildTextUserName(String name) => Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.13,
        child: Text(name, textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20CoalGreyW600),
      );

  Widget buildTextSearch() => Container(
        width: MediaQuery.of(context).size.width,
        child: Text(S.of(context).home_search, textAlign: TextAlign.center, style: TextStylesUtils.styleRegular14BlackW400),
      );

  Widget buildSearchView() => TextInputSearch(
        validateErrMsg: "",
      );

  Widget buildListSuggest() {
    final titles = ['iPhone XR', 'Samsung Galaxy Note 10', 'Oppo', 'iPhone XR', 'Samsung Galaxy Note 10', 'Oppo'];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      height: 60.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            padding: const EdgeInsets.all(8),
            child: Text(
              titles[index],
              textAlign: TextAlign.center,
              style: TextStylesUtils.styleRegular12BrownGreyW400,
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

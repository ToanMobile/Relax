import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/lib/screenutils/size_extension.dart';

class RegisterSuccessPage extends StatefulWidget {
  @override
  _RegisterSuccessPageState createState() => _RegisterSuccessPageState();
}

class _RegisterSuccessPageState extends State<RegisterSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[buildBGRegister(), buildContent()],
      ),
    );
  }

  Widget buildContent() => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
          buildIconWerry(),
          SizedBox(
            height: 36.h,
          ),
          buildTextTitleRegister(),
          buildTextContentRegister(),
        ]),
      );

  Widget buildIconWerry() => SvgPicture.asset(
        ImagesUtils.iconLoginApproval,
        width: 100.w,
        height: 100.h,
      );

  Widget buildTextTitleRegister() => Text(S.of(context).register_complete, style: TextStylesUtils.styleMedium20WhiteW600);

  Widget buildTextContentRegister() => Container(
        padding: EdgeInsets.only(top: 10.h, left: 30.w, right: 30.w),
        child: Text(
          S.of(context).register_content,
          style: TextStylesUtils.styleRegular12WhiteW400,
          textAlign: TextAlign.center,
        ),
      );

  Widget buildBGRegister() => Image.asset(
        ImagesUtils.bgLoginSusscess,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      );
}

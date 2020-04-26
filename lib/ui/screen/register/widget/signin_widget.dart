import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/res/text_styles.dart';

class SingInWidget extends StatefulWidget {
  final nameController;

  SingInWidget(this.nameController);

  @override
  _SingInWidgetState createState() => _SingInWidgetState();
}

class _SingInWidgetState extends State<SingInWidget> {
  TapGestureRecognizer _recognizerRegister;

  @override
  void initState() {
    _recognizerRegister = TapGestureRecognizer()
      ..onTap = () async {
        widget.nameController.text = await Navigator.of(context).pushReplacementNamed(RouteName.login);
      };
    super.initState();
  }

  @override
  void dispose() {
    _recognizerRegister.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text.rich(
        TextSpan(
          text: S.of(context).login_content1,
          style: TextStylesUtils.styleRegular12BrownGreyW400,
          children: [
            TextSpan(text: S.of(context).signIn, recognizer: _recognizerRegister, style: TextStylesUtils.styleRegular12PinkishOrangeW600),
            TextSpan(text: S.of(context).login_content2, style: TextStylesUtils.styleRegular12BrownGreyW400)
          ],
        ),
      ),
    );
  }
}

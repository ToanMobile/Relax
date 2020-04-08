import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/res/text_styles.dart';

class SingUpWidget extends StatefulWidget {
  final nameController;

  SingUpWidget(this.nameController);

  @override
  _SingUpWidgetState createState() => _SingUpWidgetState();
}

class _SingUpWidgetState extends State<SingUpWidget> {
  TapGestureRecognizer _recognizerRegister;

  @override
  void initState() {
    _recognizerRegister = TapGestureRecognizer()
      ..onTap = () async {
        widget.nameController.text = await Navigator.of(context).pushNamed(RouteName.register);
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
          text: S.of(context).loginUsername,
          style: TextStylesUtils().styleMedium20TextSelect,
          children: [
            TextSpan(
                text: S.of(context).signUp,
                recognizer: _recognizerRegister,
                style: TextStylesUtils().styleMedium20TextSelect),
            TextSpan(text: S.of(context).loginUsername, style: TextStylesUtils().styleMedium20TextSelect)
          ],
        ),
      ),
    );
  }
}
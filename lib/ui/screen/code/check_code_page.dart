import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/login/widget/login_field_widget.dart';
import 'package:relax/ui/widget/app_bar.dart';
import 'package:relax/ui/widget/button_progress_indicator.dart';
import 'package:relax/ui/widget/filled_round_button.dart';
import 'package:relax/viewmodel/driver_model.dart';

class CheckCodePage extends StatefulWidget {
  @override
  _CheckCodeState createState() => _CheckCodeState();
}

class _CheckCodeState extends State<CheckCodePage> {
  final _codeController = TextEditingController();
  final _codeFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(Constant.check_code);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsUtils.pale,
      appBar: AppBarIcon.back().build(context),
      body: Stack(
        children: <Widget>[
          ViewModelProvider<DriverModel>.withoutConsumer(
            viewModel: DriverModel(),
            onModelReady: (model) => {},
            builder: (context, model, child) {
              return Container(
                padding: EdgeInsets.all(40),
                child: Form(
                  key: _formKey,
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                    buildTextTitleLogin(),
                    SizedBox(
                      height: 30.h,
                    ),
                    LoginTextField(
                      controller: _codeController,
                      label: S.of(context).inputCode,
                      textInputType: TextInputType.number,
                      icon: Icons.vpn_key,
                      focusNode: _codeFocus,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (text) {
                        _codeController.text = text;
                      },
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    buildSendCode(model)
                  ]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildTextTitleLogin() => Text(S.of(context).inputCode, style: TextStylesUtils.styleRegular20CoalGreyW600);

  Widget buildSendCode(DriverModel model) {
    Widget child = model.busy
        ? Container(
            height: 150.h,
            child: Center(
              child: ButtonProgressIndicator(),
            ),
          )
        : Container(
            height: 150.h,
            child: Center(
              child: Text(
                'Send Code',
                style: TextStylesUtils.styleRegular14BlackW400,
              ),
            ),
          );
    return FilledRoundButton.withGradient(
        radius: 10,
        gradientColor: Constant.gradient_WaterMelon_Melon,
        child: child,
        cb: () {
          //var formState = Form.of(context);
          if (_formKey.currentState.validate()) {
            model.checkCode(_codeController.text).then((value) {
              if (value) {
                Navigator.pushNamed(context, RouteName.map);
              } else {
                model.showErrorMessage(context);
              }
            });
          }
        });
  }
}

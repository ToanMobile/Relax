import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/screenutil.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/login/widget/login_bg_widget.dart';
import 'package:relax/ui/screen/login/widget/signup_widget.dart';
import 'package:relax/ui/widget/button_progress_indicator.dart';
import 'package:relax/ui/widget/filled_round_button.dart';
import 'package:relax/viewmodel/login_model.dart';
import 'package:stacked/stacked.dart';

import 'widget/login_field_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
   /* _nameController.text = 'huynhvantoan.itc@gmail.com';
    _passwordController.text = '123456';*/
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsUtils.pale,
      body: Stack(
        children: <Widget>[
          BackgroundLogin(bgBackgroud: ImagesUtils.bgLogin),
          ViewModelBuilder<LoginModel>.reactive(
            viewModelBuilder: () => LoginModel(),
            disposeViewModel: false,
            onModelReady: (model) => {},
            builder: (context, model, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(40),
                child: Form(
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                    buildTextTitleLogin(),
                    SizedBox(
                      height: 30.h,
                    ),
                    SingUpWidget(_nameController),
                    SizedBox(
                      height: 80.h,
                    ),
                    buildTextUserName(),
                    SizedBox(
                      height: 30.h,
                    ),
                    LoginTextField(
                      label: S.of(context).login_username,
                      icon: Icons.person,
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (text) {},
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    buildTextPassword(),
                    SizedBox(
                      height: 10.h,
                    ),
                    LoginTextField(
                      controller: _passwordController,
                      label: S.of(context).login_password,
                      icon: Icons.vpn_key,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (text) {},
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    buildLogin(model)
                  ]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildTextTitleLogin() => Text(S.of(context).signIn, style: TextStylesUtils.styleRegular20CoalGreyW600);

  Widget buildTextUserName() => Text(S.of(context).login_username, style: TextStylesUtils.styleRegular12BrownGreyW400);

  Widget buildTextPassword() => Text(S.of(context).login_password, style: TextStylesUtils.styleRegular12BrownGreyW400);

  Widget buildLogin(LoginModel model) {
    Widget child = model.busy
        ? Container(
            height: 60,
            child: Center(
              child: ButtonProgressIndicator(),
            ),
          )
        : Container(
            height: 60,
            child: Center(
              child: Text(
                S.of(context).signIn,
                style: TextStylesUtils.styleRegular14BlackW400,
              ),
            ),
          );
    return FilledRoundButton.withGradient(
      radius: 10,
      gradientColor: Constant.gradient_WaterMelon_Melon,
      child: child,
      cb: () {
        model.login(_nameController.text, _passwordController.text).then((value) {
          if (value) {
            Navigator.pushReplacementNamed(context, RouteName.home);
          } else {
            model.showErrorMessage(context);
          }
        });
      },
    );
  }
}

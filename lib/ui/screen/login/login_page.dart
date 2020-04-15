import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
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
import 'package:relax/ui/widget/app_bar.dart';
import 'package:relax/ui/widget/button_progress_indicator.dart';
import 'package:relax/ui/widget/filled_round_button.dart';
import 'package:relax/viewmodel/login_model.dart';

import 'widget/login_field_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pwdFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    _nameController.text = 'hvtoan.dev@gmail.com';
    _passwordController.text = '123456';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsUtils.pale,
      appBar: AppBarIcon.back().build(context),
      body: Stack(
        children: <Widget>[
          BackgroundLogin(bgBackgroud: ImagesUtils.bgLogin),
          ViewModelProvider<LoginModel>.withoutConsumer(
            viewModel: LoginModel(),
            onModelReady: (model) => {

            },
            builder: (context, model, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(40),
                child: Form(
                  key: _formKey,
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
                      onFieldSubmitted: (text) {
                        _nameController.text = text;
                        FocusScope.of(context).requestFocus(_pwdFocus);
                      },
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
                      focusNode: _pwdFocus,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (text) {
                        _passwordController.text = text;
                      },
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    LoginButton(_formKey, _nameController, _passwordController)
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
}

class LoginButton extends ProviderWidget<LoginModel> {
  final nameController;
  final passwordController;
  final _formKey;

  LoginButton(this._formKey, this.nameController, this.passwordController);

 @override
  Widget build(BuildContext context, LoginModel model) {
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
         //var formState = Form.of(context);
         if (_formKey.currentState.validate()) {
           model.login(nameController.text, passwordController.text).then((value) {
             if (value) {
               Navigator.pushNamed(context, RouteName.home);
             } else {
               model.showErrorMessage(context);
             }
           });
         }
       });
  }
}

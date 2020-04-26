import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/image.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/login/widget/login_bg_widget.dart';
import 'package:relax/ui/screen/login/widget/login_field_widget.dart';
import 'package:relax/ui/screen/register/widget/signin_widget.dart';
import 'package:relax/ui/widget/app_bar.dart';
import 'package:relax/ui/widget/button_progress_indicator.dart';
import 'package:relax/ui/widget/filled_round_button.dart';
import 'package:relax/viewmodel/register_model.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:stacked/stacked.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwdFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsUtils.pale,
      appBar: AppBarIcon.back().build(context),
      body: Stack(
        children: <Widget>[
          BackgroundLogin(
            bgBackgroud: ImagesUtils.bgLogin,
          ),
          ViewModelBuilder<RegisterModel>.reactive(
            viewModelBuilder: () => RegisterModel(),
            disposeViewModel: false, // Take note here
            onModelReady: (model) {},
            builder: (context, model, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(40.w),
                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                  buildTextTitleLogin(),
                  SizedBox(
                    height: 30.h,
                  ),
                  SingInWidget(_nameController),
                  SizedBox(
                    height: 30.h,
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
                      FocusScope.of(context).requestFocus(_pwdFocus);
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  buildTextPassword(),
                  SizedBox(
                    height: 30.h,
                  ),
                  LoginTextField(
                    controller: _emailController,
                    label: S.of(context).login_password,
                    icon: Icons.vpn_key,
                    obscureText: true,
                    focusNode: _pwdFocus,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  buildTextConfirmPassword(),
                  SizedBox(
                    height: 30.h,
                  ),
                  LoginTextField(
                    controller: _passwordController,
                    label: S.of(context).login_confirm_password,
                    icon: Icons.vpn_key,
                    obscureText: true,
                    focusNode: _pwdFocus,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 120.h,
                  ),
                  RegisterButton(_nameController, _emailController, _passwordController)
                ]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildTextTitleLogin() => Text(S.of(context).signUp, style: TextStylesUtils.styleMedium20CoalGreyW600);

  Widget buildTextUserName() => Text(S.of(context).login_username, style: TextStylesUtils.styleRegular12BrownGreyW400);

  Widget buildTextPassword() => Text(S.of(context).login_password, style: TextStylesUtils.styleRegular12BrownGreyW400);

  Widget buildTextConfirmPassword() => Text(S.of(context).login_confirm_password, style: TextStylesUtils.styleRegular12BrownGreyW400);
}

class RegisterButton extends StatelessWidget {
  final nameController;
  final passwordController;
  final emailController;

  RegisterButton(this.nameController, this.emailController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<RegisterModel>(context);
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
                S.of(context).signUp,
                style: TextStylesUtils.styleRegular14WhiteW600,
              ),
            ),
          );
    return FilledRoundButton.withGradient(
      radius: 10,
      gradientColor: Constant.gradient_WaterMelon_Melon,
      child: child,
      cb: () {
        var formState = Form.of(context);
        if (formState.validate()) {
          model.register(nameController.text, emailController.text, passwordController.text).then((value) {
            if (value) {
              Navigator.pushReplacementNamed(context, RouteName.register_success);
            } else {
              model.showErrorMessage(context);
            }
          });
        }
      },
    );
  }
}

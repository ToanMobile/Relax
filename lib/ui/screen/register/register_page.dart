import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/data/model/role_entity.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
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
import 'package:stacked/stacked.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pwdFocus = FocusNode();
  int _currVal = Constant.role_shipper;
  List<RoleEntity> list = new List();

  void _group(BuildContext context) {
    if (list.length == 0) {
      list.add(
        RoleEntity(
          text: S.of(context).shipper,
          role: Constant.role_shipper,
        ),
      );
      list.add(
        RoleEntity(
          text: S.of(context).driver,
          role: Constant.role_driver,
        ),
      );
      list.add(
        RoleEntity(
          text: S.of(context).shipper_driver,
          role: Constant.role_shipper_driver,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*_nameController.text = 'ToanDev';
    _passwordController.text = '123456';
    _addressController.text = 'thon 3 hoa vinh';
    _emailController.text = 'huynhvantoan.itc@gmail.com';
    _phoneController.text = '0376542546';*/
    _group(context);
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
                padding: EdgeInsets.all(50.h),
                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
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
                      _nameController.text = text;
                      FocusScope.of(context).requestFocus(_pwdFocus);
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  buildTextEmail(),
                  SizedBox(
                    height: 30.h,
                  ),
                  LoginTextField(
                    controller: _emailController,
                    label: S.of(context).login_email,
                    icon: Icons.email,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (text) {
                      _emailController.text = text;
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
                  buildTextTitleAddress(),
                  SizedBox(
                    height: 30.h,
                  ),
                  LoginTextField(
                    controller: _addressController,
                    label: S.of(context).login_address,
                    icon: Icons.add_location,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (text) {
                      _addressController.text = text;
                    },
                  ),
                  buildTextTitlePhone(),
                  SizedBox(
                    height: 30.h,
                  ),
                  LoginTextField(
                    controller: _phoneController,
                    label: S.of(context).login_phone,
                    icon: Icons.phone,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (text) {
                      _phoneController.text = text;
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  buildRole(),
                  SizedBox(
                    height: 60.h,
                  ),
                  buildButtonRegister(model)
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

  Widget buildTextEmail() => Text(S.of(context).login_email, style: TextStylesUtils.styleRegular12BrownGreyW400);

  Widget buildTextTitleAddress() => Text(S.of(context).login_address, style: TextStylesUtils.styleRegular12BrownGreyW400);

  Widget buildTextTitlePhone() => Text(S.of(context).login_phone, style: TextStylesUtils.styleRegular12BrownGreyW400);

  Widget buildRole() {
    return Container(
      width: double.infinity,
      height: 480.h,
      child: Column(
        children: list
            .map((t) => RadioListTile(
                title: Text(
                  "${t.text}",
                  style: TextStylesUtils.styleMedium18Black,
                ),
                groupValue: _currVal,
                value: t.role,
                onChanged: (val) {
                  setState(() {
                    _currVal = val;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildButtonRegister(RegisterModel model) {
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
        model.register(_nameController.text, _emailController.text, _passwordController.text, _addressController.text, _phoneController.text, _currVal).then(
          (value) {
            if (value) {
              Navigator.pushReplacementNamed(context, RouteName.home);
            } else {
              model.showErrorMessage(context);
            }
          },
        );
      },
    );
  }
}

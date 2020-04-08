import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/ui/screen/login/widget/login_bg_widget.dart';
import 'package:relax/ui/screen/login/widget/login_progress_widget.dart';
import 'package:relax/ui/screen/login/widget/signup_widget.dart';
import 'package:relax/ui/widget/app_bar.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/viewmodel/login_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
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
    _nameController.text = 'hvtoan.dev@gmail.com';
    _passwordController.text = '123456';
    return ViewModelProvider<LoginModel>.withoutConsumer(
      viewModel: LoginModel(),
      onModelReady: (model) => model.idle,
      builder: (context, model, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorsUtils.pale,
        appBar: AppBarIcon.back().build(context),
        body: Stack(
          children: <Widget>[
            BackgroundLogin(),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(40),
              child: Form(
                key: _formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                  buildTextTitleLogin(),
                  SizedBox(
                    height: 10.h,
                  ),
                  SingUpWidget(_nameController),
                  SizedBox(
                    height: 40.h,
                  ),
                  buildTextUserName(),
                  SizedBox(
                    height: 10.h,
                  ),
                  LoginTextField(
                    label: S.of(context).loginUsername,
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
                    height: 10.h,
                  ),
                  LoginTextField(
                    controller: _passwordController,
                    label: S.of(context).loginPassword,
                    icon: Icons.vpn_key,
                    obscureText: true,
                    focusNode: _pwdFocus,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  LoginProgressButton(_formKey, _nameController, _passwordController, null)
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextTitleLogin() => Text(S.of(context).signIn, style: TextStylesUtils().styleMedium20TextSelect);

  Widget buildTextUserName() => Text(S.of(context).loginUsername, style: TextStylesUtils().styleMedium20TextSelect);

  Widget buildTextPassword() => Text(S.of(context).loginPassword, style: TextStylesUtils().styleMedium20TextSelect);
}

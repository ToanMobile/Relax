import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/text_styles.dart';

class LoginTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final ValueChanged<String> onFieldSubmitted;

  LoginTextField({
    this.label,
    this.icon,
    this.controller,
    this.obscureText: false,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.textInputType,
    this.onFieldSubmitted,
  });

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  TextEditingController controller;

  ValueNotifier<bool> obscureNotifier;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    obscureNotifier = ValueNotifier(widget.obscureText);
    super.initState();
  }

  @override
  void dispose() {
    obscureNotifier.dispose();
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: obscureNotifier,
      builder: (context, value, child) => TextFormField(
        controller: controller,
        obscureText: value,
        keyboardType: widget.textInputType,
        validator: (text) {
          var validator = widget.validator ?? (_) => null;
          return text.trim().length > 0 ? validator(text) : S.of(context).fieldNotNull;
        },
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        style: TextStylesUtils.styleRegular14Black,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: theme.hintColor, size: 60.w),
          hintText: widget.label,
          hintStyle: TextStylesUtils.styleRegular14BlackW400,
          suffixIcon: LoginTextFieldSuffixIcon(
            controller: controller,
            obscureText: widget.obscureText,
            obscureNotifier: obscureNotifier,
          ),
          filled: true,
          fillColor: ColorsUtils.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

class LoginTextFieldSuffixIcon extends StatelessWidget {
  final TextEditingController controller;

  final ValueNotifier<bool> obscureNotifier;

  final bool obscureText;

  LoginTextFieldSuffixIcon({this.controller, this.obscureNotifier, this.obscureText});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Offstage(
            offstage: !obscureText,
            child: InkWell(
              onTap: () {
//              debugPrint('onTap');
                obscureNotifier.value = !obscureNotifier.value;
              },
              child: ValueListenableBuilder(
                valueListenable: obscureNotifier,
                builder: (context, value, child) => Icon(
                  Icons.remove_red_eye,
                  size: 60.w,
                  color: value ? theme.hintColor : theme.accentColor,
                ),
              ),
            ),
          ),
          LoginTextFieldClearIcon(controller)
        ],
      ),
    );
  }
}

class LoginTextFieldClearIcon extends StatefulWidget {
  final TextEditingController controller;

  LoginTextFieldClearIcon(this.controller);

  @override
  _LoginTextFieldClearIconState createState() => _LoginTextFieldClearIconState();
}

class _LoginTextFieldClearIconState extends State<LoginTextFieldClearIcon> {
  ValueNotifier<bool> notifier;

  @override
  void initState() {
    notifier = ValueNotifier(widget.controller.text.isEmpty);
    widget.controller.addListener(() {
      notifier.value = widget.controller.text.isEmpty;
    });
    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, bool value, child) {
        return Offstage(
          offstage: value,
          child: child,
        );
      },
      child: InkWell(
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.controller.clear();
            });
          },
          child: Icon(CupertinoIcons.clear, size: 60.w, color: Theme.of(context).hintColor)),
    );
  }
}

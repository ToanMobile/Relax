import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/lib/screenutils/size_extension.dart';

Future<T> showTransparentDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: const Color(0x00FFFFFF),
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

class ProgressDialog extends Dialog {
  const ProgressDialog({Key key, this.hintText}) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: 88.0,
          width: 120.0,
          decoration: ShapeDecoration(
              color: const Color(0xFF3A3A3A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Theme(
                data: ThemeData(
                    cupertinoOverrideTheme: CupertinoThemeData(
                        brightness: Brightness.dark // 局部指定夜间模式，加载圈颜色会设置为白色
                        )),
                child: const CupertinoActivityIndicator(radius: 14.0),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                hintText,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

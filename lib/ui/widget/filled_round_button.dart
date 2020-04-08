import 'package:flutter/material.dart';
import 'package:relax/res/colors.dart';

class FilledRoundButton extends StatefulWidget {
  final Gradient gradientColor;
  final Color pureColor;
  final double radius;
  final Text text;
  final Icon prefIcon;
  final VoidCallback cb;
  final Widget child;

  FilledRoundButton.withGradient({
    @required this.gradientColor,
    this.radius = 30.0,
    this.text,
    this.prefIcon,
    this.child,
    this.cb,
  }) : this.pureColor = null;

  FilledRoundButton.withColor({
    @required this.pureColor,
    this.radius = 30.0,
    this.text,
    this.prefIcon,
    this.child,
    this.cb,
  }) : this.gradientColor = null;

  @override
  _FilledRoundButtonState createState() => _FilledRoundButtonState();
}

class _FilledRoundButtonState extends State<FilledRoundButton> {
  @override
  Widget build(BuildContext context) {
    Widget childWidgetButton;
    if (widget.child == null) {
      childWidgetButton = widget.prefIcon == null
          ? Center(child: widget.text)
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                widget.prefIcon,
                const SizedBox(width: 5.0),
                Container(
                  child: widget.text,
                )
              ],
            );
    } else {
      childWidgetButton = widget.child;
    }
    return Container(
      decoration: BoxDecoration(
        color: widget.pureColor,
        gradient: widget.gradientColor,
        borderRadius: BorderRadius.circular(
          widget.radius,
        ),
        boxShadow: [
          BoxShadow(
              color: ColorsUtils.buttonShadow,
              offset: Offset(0, 2),
              blurRadius: 13,
              spreadRadius: 0)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: ColorsUtils.paleSalmon,
          borderRadius: BorderRadius.circular(
            widget.radius,
          ),
          onTap: widget.cb == null ? () => {} : widget.cb,
          child: childWidgetButton,
        ),
      ),
    );
  }
}

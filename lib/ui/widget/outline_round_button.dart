import 'package:flutter/material.dart';
import 'package:relax/common/gradient_painter_utls.dart';

class OutlineRoundButton extends StatefulWidget {
  final Gradient gradientColor;
  final Color pureColor;
  final double radius, strokeWidth;
  final Text text;
  final Icon prefIcon;
  final VoidCallback cb;

  OutlineRoundButton.withGradientBorder({
    @required this.gradientColor,
    this.radius = 30.0,
    this.strokeWidth = 3.0,
    this.text,
    this.prefIcon,
    this.cb,
  }) : this.pureColor = null;

  OutlineRoundButton.withColorBorder({
    @required this.pureColor,
    this.radius = 30.0,
    this.strokeWidth = 3.0,
    this.text,
    this.prefIcon,
    this.cb,
  }) : this.gradientColor = null;

  @override
  _OutlineRoundButtonState createState() => _OutlineRoundButtonState();
}

class _OutlineRoundButtonState extends State<OutlineRoundButton> {
  @override
  Widget build(BuildContext context) {
    Widget childWidgetButton = widget.prefIcon == null
        ? Center(child: widget.text)
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.prefIcon,
              const SizedBox(
                width: 5.0,
              ),
              widget.text,
            ],
          );

    // Gradient outline round button
    if (widget.gradientColor != null) {
      GradientPainter _painter = GradientPainter(
        radius: widget.radius,
        strokeWidth: widget.strokeWidth,
        gradientColor: widget.gradientColor,
      );

      return CustomPaint(
        painter: _painter,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // make splash shape fit round button when tap,
            // if not specified, splash shape is rectangle instead of round
            borderRadius: BorderRadius.circular(widget.radius),
            highlightColor: Colors.transparent,
            onTap: widget.cb == null ? () => {} : widget.cb,
            child: childWidgetButton,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        // make splash shape fit round button when tap,
        // if not specified, splash shape is rectangle instead of round
        borderRadius: BorderRadius.circular(widget.radius),
        border: Border.all(
          color: widget.pureColor,
          width: widget.strokeWidth,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(widget.radius),
          highlightColor: Colors.transparent,
          onTap: widget.cb == null ? () => {} : widget.cb,
          child: childWidgetButton,
        ),
      ),
    );
  }
}

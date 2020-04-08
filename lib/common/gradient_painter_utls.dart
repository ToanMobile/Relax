import 'package:flutter/material.dart';

class GradientPainter extends CustomPainter {

  final Paint _paint = Paint();
  final double radius, strokeWidth;
  final Gradient gradientColor;


  GradientPainter({@required this.radius, @required this.strokeWidth, @required this.gradientColor}) :
      assert(radius > 0, "Radius must be greater than 0!"),
      assert(strokeWidth > 0, "Stroke width must be greater than 0!");

  @override
  void paint(Canvas canvas, Size size) {
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(this.radius));

    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth, size.width - strokeWidth * 2.0, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius - strokeWidth));

    _paint.shader = gradientColor.createShader(outerRect);
    var diffPath = Path.combine(PathOperation.difference, Path()..addRRect(outerRRect), Path()..addRRect(innerRRect));

    canvas.drawPath(diffPath, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

}
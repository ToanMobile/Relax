import 'package:flutter/material.dart';
import 'package:relax/res/image.dart';

class ProfileImage extends StatelessWidget {
  final double height, width;
  final Color color;
  ProfileImage(
      {this.height = 100.0, this.width = 100.0, this.color = Colors.white});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: ExactAssetImage(ImagesUtils.iconUser),
          fit: BoxFit.contain,
        ),
        border: Border.all(
          color: color,
          width: 3.0,
        ),
      ),
    );
  }
}

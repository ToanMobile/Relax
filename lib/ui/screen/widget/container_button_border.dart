import 'package:relax/res/colors.dart';
import 'package:relax/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:relax/lib/screenutils/size_extension.dart';

class ContainerButtonBorder extends StatefulWidget {
  final String title;
  final TextStyle textStyle;
  final TextStyle textStyleFocus;
  final Color bgColor;
  final Color bgColorFocus;
  final bool isCenter;
  final int height;
  final int width;
  final VoidCallback cb;

  ContainerButtonBorder(
      {this.width = 250,
      this.height = 200,
      this.title = '',
      this.isCenter = true,
      this.cb,
      this.textStyle,
      this.textStyleFocus,
      this.bgColorFocus = ColorsUtils.menuSelectDark,
      this.bgColor = ColorsUtils.menuBackground});

  @override
  ContainerButtonBorderState createState() => ContainerButtonBorderState();
}

class ContainerButtonBorderState extends State<ContainerButtonBorder> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleNormal;
    TextStyle textStyleFocus;
    if (widget.textStyle == null) {
      textStyleNormal = TextStylesUtils().styleMedium20White;
    } else {
      textStyleNormal = widget.textStyle;
    }
    if (widget.textStyleFocus == null) {
      textStyleFocus = TextStylesUtils().styleMedium20White;
    } else {
      textStyleFocus = widget.textStyleFocus;
    }
    return Container(
      width: widget.width.w,
      height: widget.height.h,
      decoration: BoxDecoration(
        color: _focusNode.hasFocus ? widget.bgColorFocus : widget.bgColor,
        border: Border.all(color: ColorsUtils.white),
      ),
      child: FlatButton(
        onPressed: widget.cb == null ? () => {} : widget.cb,
        color: ColorsUtils.transparent,
        focusNode: _focusNode,
        child: Text(widget.title, textAlign: TextAlign.center, style: _focusNode.hasFocus ? textStyleFocus : textStyleNormal),
      ),
    );
  }
}

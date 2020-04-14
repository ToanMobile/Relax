import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/text_styles.dart';

class ContainerButton extends StatefulWidget {
  final String title;
  final String image;
  final TextStyle textStyle;
  final TextStyle textStyleFocus;
  final Color bgColor;
  final Color bgColorFocus;
  final bool isExpanded;
  final bool isCenter;
  final VoidCallback cb;

  ContainerButton(
      {this.isExpanded = false,
      this.title = '',
      this.image = '',
      this.isCenter = true,
      this.cb,
      this.textStyle,
      this.textStyleFocus,
      this.bgColorFocus = ColorsUtils.lightPink,
      this.bgColor = ColorsUtils.transparent});

  @override
  _ContainerButtonState createState() => _ContainerButtonState();
}

class _ContainerButtonState extends State<ContainerButton> {
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
    Widget childWidgetContainer;
    Widget childWidgetText;
    TextStyle textStyleNormal;
    TextStyle textStyleFocus;
    if (widget.textStyle == null) {
      textStyleNormal = TextStylesUtils.styleMedium18Black;
    } else {
      textStyleNormal = widget.textStyle;
    }
    if (widget.textStyleFocus == null) {
      textStyleFocus = TextStylesUtils.styleMedium20White;
    } else {
      textStyleFocus = widget.textStyleFocus;
    }
    if (widget.title.isNotEmpty) {
      if (!widget.isCenter) {
        childWidgetText = FlatButton(
          onPressed: widget.cb == null ? () => {} : widget.cb,
          focusColor: widget.bgColorFocus,
          focusNode: _focusNode,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.title, style: _focusNode.hasFocus ? textStyleFocus : textStyleNormal),
          ),
        );
      } else {
        childWidgetText = Container(
          alignment: Alignment.bottomLeft,
          decoration: _focusNode.hasFocus
              ? BoxDecoration(
                  border: Border(bottom: BorderSide(color: ColorsUtils.menuSelect)),
                  gradient: LinearGradient(
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    colors: [Color(0x00000000), Color(0x1F000000), Color(0x96000000)],
                  ),
                )
              : BoxDecoration(
                  gradient: LinearGradient(
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    colors: [Color(0x24000000), Color(0x82000000), Color(0xd5000000)],
                  ),
                ),
          child: FlatButton(
            onPressed: widget.cb == null ? () => {} : widget.cb,
            color: ColorsUtils.transparent,
            focusNode: _focusNode,
            child: Text(widget.title, textAlign: TextAlign.left, style: _focusNode.hasFocus ? textStyleFocus : textStyleNormal),
          ),
        );
      }
    } else {
      childWidgetText = MaterialButton(onPressed: widget.cb == null ? () => {} : widget.cb, focusColor: ColorsUtils.menuSelectDark);
    }
    if (widget.image.isNotEmpty) {
      childWidgetContainer = Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.bgColor,
          image: DecorationImage(
            image: AssetImage(widget.image),
            fit: BoxFit.cover,
          ),
        ),
        child: childWidgetText,
      );
    } else {
      childWidgetContainer = Container(
        height: double.infinity,
        width: double.infinity,
        color: widget.bgColor,
        child: childWidgetText,
      );
    }
    if (widget.isExpanded) {
      return Expanded(
        child: childWidgetContainer,
        flex: 1,
      );
    } else {
      return childWidgetContainer;
    }
  }
}

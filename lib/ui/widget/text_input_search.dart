import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/colors.dart';

typedef ValidateFunc = bool Function(String);
typedef GetTextCb = void Function(String);

class TextInputSearch extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback cb;
  final bool isInputValid;
  final String validateErrMsg;

  TextInputSearch({this.validateErrMsg, this.controller, this.isInputValid = false, this.cb});

  @override
  _TextInputSearchState createState() => _TextInputSearchState();
}

class _TextInputSearchState extends State<TextInputSearch> {
  @override
  Widget build(BuildContext context) {
    if (widget.isInputValid) {
      return _buildTextField();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextField(),
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            widget.validateErrMsg,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 150.h,
      child: CupertinoTextField(
        controller: widget.controller,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
        clearButtonMode: OverlayVisibilityMode.editing,
        placeholder: S.of(context).home_search,
        textInputAction: TextInputAction.search,
        onSubmitted: (newValue) => widget.cb == null ? () => {} : widget.cb,
        suffix: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          width: 120.w,
          height: 120.h,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            child: Icon(Icons.search, color: Colors.white),
            onPressed: widget.cb == null ? () => {} : widget.cb,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            gradient: Constant.gradient_WaterMelon_Melon,
            boxShadow: [BoxShadow(color: Color(0x42ff8258), offset: Offset(0, 7), blurRadius: 14, spreadRadius: 0)],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: ColorsUtils.buttonShadow, offset: Offset(0, 11), blurRadius: 14, spreadRadius: 0)],
        ),
      ),
    );
  }
}

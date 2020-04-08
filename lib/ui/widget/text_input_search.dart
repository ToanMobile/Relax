import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/lib/screenutils/size_extension.dart';

typedef ValidateFunc = bool Function(String);
typedef GetTextCb = void Function(String);

class TextInputSearch extends StatefulWidget {
  final TextEditingController controller;

  final bool isInputValid;
  final String validateErrMsg;

  TextInputSearch(
      {this.validateErrMsg, this.controller, this.isInputValid = false});

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
        const SizedBox(
          height: 5.0,
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
      height: 55.h,
      child: CupertinoTextField(
        controller: widget.controller,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        clearButtonMode: OverlayVisibilityMode.editing,
        placeholder: S.of(context).close,
        suffix: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          width: 40.w,
          height: 40.h,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            child: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              print('');
            },
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            gradient: Constant.gradient_WaterMelon_Melon,
            boxShadow: [
              BoxShadow(
                  color: Color(0x42ff8258),
                  offset: Offset(0, 7),
                  blurRadius: 14,
                  spreadRadius: 0)
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: ColorsUtils.buttonShadow,
                offset: Offset(0, 11),
                blurRadius: 14,
                spreadRadius: 0)
          ],
        ),
      ),
    );
  }
}

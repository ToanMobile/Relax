import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/data/model/request_info_entity.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/login/widget/login_field_widget.dart';
import 'package:relax/viewmodel/driver_model.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'button_progress_indicator.dart';
import 'filled_round_button.dart';

class BottomSheetWidget extends StatefulWidget {
  final RequestInfo requestPool;
  final DriverModel model;

  BottomSheetWidget(this.model, this.requestPool);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      height: 1000.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buildTextUserName(),
          SizedBox(
            height: 30.h,
          ),
          LoginTextField(
            label: S.of(context).login_username,
            icon: Icons.person,
            controller: _nameController,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(
            height: 30.h,
          ),
          buildTextTitleAddress(),
          SizedBox(
            height: 30.h,
          ),
          LoginTextField(
            controller: _addressController,
            label: S.of(context).login_address,
            icon: Icons.add_location,
            textInputAction: TextInputAction.done,
          ),
          SizedBox(
            height: 30.h,
          ),
          buildTextTitlePhone(),
          SizedBox(
            height: 30.h,
          ),
          LoginTextField(
            controller: _phoneController,
            label: S.of(context).login_phone,
            textInputType: TextInputType.phone,
            icon: Icons.phone,
            textInputAction: TextInputAction.done,
          ),
          SizedBox(
            height: 60.h,
          ),
          buildButtonRequest(widget.model, widget.requestPool)
        ],
      ),
    );
  }

  Widget buildTextUserName() => Text(S.of(context).login_username, style: TextStylesUtils.styleRegular12BrownGreyW400);

  Widget buildTextTitleAddress() => Text(S.of(context).login_address, style: TextStylesUtils.styleRegular12BrownGreyW400);

  Widget buildTextTitlePhone() => Text(S.of(context).login_phone, style: TextStylesUtils.styleRegular12BrownGreyW400);

  Widget buildButtonRequest(DriverModel model, RequestInfo requestInfo) {
    Widget child = model.busy
        ? Container(
            height: 150.h,
            child: Center(
              child: ButtonProgressIndicator(),
            ),
          )
        : Container(
            height: 150.h,
            child: Center(
              child: Text(
                S.of(context).actionConfirm,
                style: TextStylesUtils.styleRegular14WhiteW600,
              ),
            ),
          );
    return FilledRoundButton.withGradient(
      radius: 10,
      gradientColor: Constant.gradient_WaterMelon_Melon,
      child: child,
      cb: () async {
        if (_nameController.text.isNotEmpty && _addressController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
          requestInfo.guest_Name = _nameController.text;
          requestInfo.guest_Address = _addressController.text;
          requestInfo.guest_Phone = _phoneController.text;
          await model.addRequestPool(requestInfo).then((value) {
            if (value) {
              print('Done');
              model.showErrorMessage(context, message: S.of(context).send_data_ok);
              Navigator.of(context).pop();
            } else {
              model.showErrorMessage(context);
            }
          });
        } else {
          model.showErrorMessage(context, message: S.of(context).send_data_input);
        }
      },
    );
  }
}

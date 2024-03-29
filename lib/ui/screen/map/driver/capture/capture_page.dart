import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/data/model/driver_info_entity.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/provider/view_state_widget.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/login/widget/login_field_widget.dart';
import 'package:relax/ui/screen/widget/container_button.dart';
import 'package:relax/ui/widget/button_progress_indicator.dart';
import 'package:relax/ui/widget/filled_round_button.dart';
import 'package:relax/ui/widget/image_picker_gallery_camera.dart';
import 'package:relax/viewmodel/driver_model.dart';
import 'package:stacked/stacked.dart';

enum Type { LICENCE, DRIVER, CERTIFICATE }

class CapturePage extends StatefulWidget {
  @override
  CaptureState createState() => CaptureState();
}

class CaptureState extends State<CapturePage> {
  final DriverInfoEntity driverEntity = DriverInfoEntity();
  final _sdtController = TextEditingController();
  final _sdtFocus = FocusNode();
  final sdtFormKey = GlobalKey<FormState>();
  var flag;

  @override
  void dispose() {
    _sdtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<DriverModel>.reactive(
        viewModelBuilder: () => DriverModel(),
        disposeViewModel: false,
        onModelReady: (model) => {},
        builder: (context, model, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  children: [
                    Container(
                      width: ScreenUtil.screenWidthDp / 2,
                      height: 800.h,
                      child: Column(
                        children: [
                          ContainerButton(
                            isExpanded: true,
                            isCenter: false,
                            title: 'Driver licence',
                            cb: () {
                              selectCapture(context, model, Type.LICENCE);
                            },
                          ),
                          buildImage(model, Type.LICENCE),
                        ],
                      ),
                    ),
                    Container(
                      width: ScreenUtil.screenWidthDp / 2,
                      height: 800.h,
                      child: Column(
                        children: [
                          ContainerButton(
                            isExpanded: true,
                            isCenter: false,
                            title: 'Potrait of driver',
                            cb: () {
                              selectCapture(context, model, Type.DRIVER);
                            },
                          ),
                          buildImage(model, Type.DRIVER),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: ScreenUtil.screenWidthDp / 2,
                      height: 800.h,
                      child: Column(
                        children: [
                          ContainerButton(
                            isExpanded: true,
                            isCenter: false,
                            title: 'Policy certificate ',
                            cb: () {
                              selectCapture(context, model, Type.CERTIFICATE);
                            },
                          ),
                          buildImage(model, Type.CERTIFICATE),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                buildSendEmail(model)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildSendEmail(DriverModel driverModel) => Form(
        key: sdtFormKey,
        child: Container(
          width: double.infinity,
          height: 200.h,
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: LoginTextField(
                  label: S.of(context).login_phone,
                  icon: Icons.phone,
                  textInputType: TextInputType.phone,
                  controller: _sdtController,
                  focusNode: _sdtFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (text) {
                    if (sdtFormKey.currentState.validate()) {
                      _sdtController.text = text;
                      FocusScope.of(context).requestFocus(_sdtFocus);
                    } else {
                      driverModel.showErrorMessage(context);
                    }
                  },
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Container(
                width: 200.w,
                height: 120.h,
                child: FilledRoundButton.withGradient(
                  radius: 10,
                  gradientColor: Constant.gradient_WaterMelon_Melon,
                  text: Text(S.of(context).send_otp, textAlign: TextAlign.center, style: TextStylesUtils.styleMedium18White),
                  cb: () async {
                    if (sdtFormKey.currentState.validate()) {
                      print(driverModel.getUser.tel.substring(6, driverModel.getUser.tel.length).toString());
                      if(_sdtController.text.endsWith(driverModel.getUser.tel.substring(6, driverModel.getUser.tel.length))) {
                        await driverModel.sendOtp(_sdtController.text).then(
                              (value) {
                            if (value) {
                              Navigator.pushReplacementNamed(context, RouteName.code, arguments: driverEntity);
                            } else {
                              driverModel.showErrorMessage(context);
                            }
                          },
                        );
                      }else{
                        driverModel.showErrorMessage(context, message: S.of(context).verify_phone_error);
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      );

  Widget buildImage(DriverModel model, Type type) {
    String image;
    if (type == Type.LICENCE) {
      image = driverEntity.imgLicence;
    } else if (type == Type.DRIVER) {
      image = driverEntity.imgDriver;
    } else if (type == Type.CERTIFICATE) {
      image = driverEntity.imgCertificate;
    }
    print(image);
    if (flag == type) {
      Widget child = model.busy
          ? Container(
              width: 500.w,
              height: 700.h,
              child: Center(
                child: ButtonProgressIndicator(color: ColorsUtils.coralPink),
              ),
            )
          : Container(
              width: 500.w,
              height: 700.h,
              child: image != null
                  ? Image(image: CachedNetworkImageProvider(image))
                  : ViewStateEmptyWidget(onPressed: () {
                      selectCapture(context, model, type);
                    }),
            );
      return child;
    }
    return Container(
      width: 500.w,
      height: 700.h,
      child: image != null
          ? Image(image: CachedNetworkImageProvider(image))
          : ViewStateEmptyWidget(onPressed: () {
              selectCapture(context, model, type);
            }),
    );
  }

  selectCapture(BuildContext context, DriverModel model, Type type) async {
    final _selectCapture = CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(S.of(context).gallery),
          onPressed: () {
            getImage(model, ImgSource.Gallery, type);
            Navigator.of(context).pop();
          },
        ),
        CupertinoActionSheetAction(
          child: Container(child: Text(S.of(context).capture)),
          onPressed: () {
            getImage(model, ImgSource.Camera, type);
            Navigator.of(context).pop();
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(child: Text(S.of(context).actionCancel), onPressed: () => Navigator.of(context).pop()),
    );
    showCupertinoModalPopup(context: context, builder: (context) => _selectCapture);
  }

  Future getImage(DriverModel model, ImgSource source, Type type) async {
    flag = type;
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      maxWidth: 500.w,
      maxHeight: 700.h,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ),
    );
    model.uploadFile(image, type).then(
      (value) {
        if (type == Type.LICENCE) {
          driverEntity.imgLicence = value;
        } else if (type == Type.DRIVER) {
          driverEntity.imgDriver = value;
        } else if (type == Type.CERTIFICATE) {
          driverEntity.imgCertificate = value;
        }
      },
    );
  }
}

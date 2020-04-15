import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/provider/view_state_widget.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/login/widget/login_field_widget.dart';
import 'package:relax/ui/screen/widget/container_button.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/ui/widget/filled_round_button.dart';
import 'package:relax/ui/widget/image_picker_gallery_camera.dart';
import 'package:relax/viewmodel/driver_model.dart';

enum Type { LICENCE, DRIVER, CERTIFICATE }

class CapturePage extends StatefulWidget {
  @override
  CaptureState createState() => CaptureState();
}

class CaptureState extends State<CapturePage> {
  File _imageLicence;
  File _imageDriver;
  File _imageCertificate;
  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelProvider<DriverModel>.withoutConsumer(
        viewModel: DriverModel(),
        onModelReady: (model) => {},
        builder: (context, model, child) {
          return Column(
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
                            selectCapture(context, Type.LICENCE);
                          },
                        ),
                        buildImage(Type.LICENCE),
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
                            selectCapture(context, Type.DRIVER);
                          },
                        ),
                        buildImage(Type.DRIVER),
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
                            selectCapture(context, Type.CERTIFICATE);
                          },
                        ),
                        buildImage(Type.CERTIFICATE),
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
          );
        },
      ),
    );
  }

  Widget buildSendEmail(DriverModel driverModel) => Container(
        child: Row(
          children: [
            LoginTextField(
              label: S.of(context).login_email,
              icon: Icons.email,
              controller: _emailController,
              focusNode: _emailFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (text) {
                _emailController.text = text;
                FocusScope.of(context).requestFocus(_emailFocus);
              },
            ),
            FilledRoundButton.withGradient(
              radius: 10,
              gradientColor: Constant.gradient_WaterMelon_Melon,
              text: Text('Send Email', textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20White),
              cb: () {
                driverModel.sendEmail(_emailController.text).then((value) {
                  if (value) {
                    Navigator.pushNamed(context, RouteName.code);
                  } else {
                    ViewStateErrorWidget(error: null, onPressed: () {});
                  }
                });
              },
            )
          ],
        ),
      );

  Widget buildImage(Type type) {
    File image;
    if (type == Type.LICENCE) {
      image = _imageLicence;
    } else if (type == Type.DRIVER) {
      image = _imageDriver;
    } else if (type == Type.CERTIFICATE) {
      image = _imageCertificate;
    }
    return Container(
      width: 500.w,
      height: 700.h,
      child: image != null ? Image.file(image) : Container(),
    );
  }

  selectCapture(BuildContext context, Type type) async {
    final _selectCapture = CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text('Galary'),
          onPressed: () {
            getImage(ImgSource.Gallery, type);
            Navigator.of(context).pop();
          },
        ),
        CupertinoActionSheetAction(
          child: Container(child: Text('Capture')),
          onPressed: () {
            getImage(ImgSource.Camera, type);
            Navigator.of(context).pop();
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(child: Text('Cancel'), onPressed: () => Navigator.of(context).pop()),
    );
    showCupertinoModalPopup(context: context, builder: (context) => _selectCapture);
  }

  Future getImage(ImgSource source, Type type) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      maxWidth: 500.w,
      maxHeight: 700.h,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      if (type == Type.LICENCE) {
        _imageLicence = image;
      } else if (type == Type.DRIVER) {
        _imageDriver = image;
      } else if (type == Type.CERTIFICATE) {
        _imageCertificate = image;
      }
    });
  }
}

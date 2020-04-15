import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/config/router_manger.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/widget/container_button.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/ui/widget/filled_round_button.dart';
import 'package:relax/ui/widget/image_picker_gallery_camera.dart';

enum Type { LICENCE, DRIVER, CERTIFICATE }

class CapturePage extends StatefulWidget {
  @override
  CaptureState createState() => CaptureState();
}

class CaptureState extends State<CapturePage> {
  File _imageLicence;
  File _imageDriver;
  File _imageCertificate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          buildGoogleMap()
        ],
      ),
    );
  }

  Widget buildGoogleMap() => Center(
        child: Container(
          width: 400.w,
          height: 130.h,
          child: FilledRoundButton.withGradient(
            radius: 10,
            gradientColor: Constant.gradient_WaterMelon_Melon,
            text: Text('Google Map', textAlign: TextAlign.center, style: TextStylesUtils.styleMedium20White),
            cb: () {
              Navigator.pushNamed(context, RouteName.map);
            },
          ),
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

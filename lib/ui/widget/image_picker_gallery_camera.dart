library image_picker_gallery_camera;
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerGC{


  static Future pickImage({
    @required BuildContext context,
    @required ImgSource source,
    double maxWidth,
    double maxHeight,
    Icon cameraIcon,
    Icon galleryIcon,
    int imageQuality}) async {
    assert(source != null);
    assert(imageQuality == null || (imageQuality >= 0 && imageQuality <= 100));

    if (maxWidth != null && maxWidth < 0) {
      throw ArgumentError.value(maxWidth, 'maxWidth cannot be negative');
    }

    if (maxHeight != null && maxHeight < 0) {
      throw ArgumentError.value(maxHeight, 'maxHeight cannot be negative');
    }

    switch(source){

      case ImgSource.Camera:
        return await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: maxWidth,maxHeight: maxHeight);
        break;
      case ImgSource.Gallery:
        return await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: maxWidth,maxHeight: maxHeight);
        break;
      case ImgSource.Both:
        return await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return  AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  InkWell(
                    onTap: () async {
                      ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: maxWidth,maxHeight: maxHeight).then((image){
                        Navigator.pop(context,image);

                      });

                    },
                    child: Container(
                      child: ListTile(
                          title: Text("Gallery"),
                          leading:galleryIcon!=null?galleryIcon:Icon(Icons.image,color: Colors.deepPurple,)
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 1,
                    color: Colors.black12,
                  ),
                  InkWell(
                    onTap: () async {
                      ImagePicker.pickImage(source: ImageSource.camera, maxWidth: maxWidth,maxHeight: maxHeight).then((image){
                        Navigator.pop(context,image);
                      });
                    },
                    child: Container(
                      child: ListTile(
                          title: Text("Camera"),
                          leading:cameraIcon!=null?cameraIcon:Icon(Icons.camera,color: Colors.deepPurple,)
                      ),
                    ),
                  ),

                ],
              ),
            );

          },
        );


    }


  }


}

enum ImgSource { Camera, Gallery,Both }
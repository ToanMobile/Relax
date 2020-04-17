import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/driver_entity.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/model/verhicle_entity.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/screen/map/driver/capture/capture_page.dart';
import 'package:relax/viewmodel/login_model.dart';
import 'base_repository.dart';

class DriverRepository {
  static final FirebaseApp app = FirebaseApp.configure(
    name: 'smartway24',
    options: FirebaseOptions(
      googleAppID: '1:872763368063:android:126c7f421e53ba888bd54a',
      gcmSenderID: '872763368063',
      apiKey: 'AIzaSyA5PadjaY5HNfo8r6tJJtTyJF7oJRhC1Ds',
      projectID: 'smartway24-30c7d',
    ),
  ) as FirebaseApp;
  final FirebaseStorage storage = FirebaseStorage(app: app, storageBucket: 'gs://smartway24-30c7d.appspot.com/');
  static final CollectionReference driverCollection = Firestore.instance.collection('driverInfos');

  static Future uploadFile(File image, Type type) async {
    try {
      String fileName;
      if (type == Type.LICENCE) {
        fileName = 'LICENCE';
      } else if (type == Type.DRIVER) {
        fileName = 'DRIVER';
      } else if (type == Type.CERTIFICATE) {
        fileName = 'CERTIFICATE';
      }
      LoginEntity user = JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preLoginUser));
      String path = user.uid ?? "Unknown";
      StorageReference storageReference = FirebaseStorage.instance.ref().child('$path/$fileName');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      var url = await (await uploadTask.onComplete).ref.getDownloadURL();
      return url;
    } catch (e) {
      printLog(e);
      return null;
    }
  }

  static Future<List<DropdownMenuItem<VehicleEntity>>> getListVehicles() async {
    List<DropdownMenuItem<VehicleEntity>> list = new List();
    CollectionReference infoCollection = Firestore.instance.collection('vehicles');
    await infoCollection.getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach(
        (doc) {
          var vehicle = VehicleEntity();
          vehicle.description = doc.data['description'];
          vehicle.max_weight = doc.data['max_weight'];
          list.add(
            DropdownMenuItem(
              value: vehicle,
              child: Text(
                vehicle.description,
                style: TextStylesUtils.styleRegular14BlackW400,
              ),
            ),
          );
        },
      );
    });
    return list;
  }

  static Future addDriver(DriverEntity data, String email) async {
    LoginEntity user = JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preLoginUser));
    data.user = user;
    data.email = email;
    data.status = 'waiting';
    await driverCollection.document(user.uid).setData(data.toJson());
    return;
  }

  static Future updateDriver(DriverEntity data) async {
    LoginEntity user = JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preLoginUser));
    await driverCollection.document(user.uid).updateData(data.toJson());
    return;
  }

  static void printLog(dynamic data) {
    BaseRepository.logger.e(data);
  }
}

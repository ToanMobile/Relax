import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/driver_info_entity.dart';
import 'package:relax/data/model/driver_offer_entity.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/model/request_info_entity.dart';
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
  static final CollectionReference driverInfoCollection = Firestore.instance.collection('driverInfos');
  static final LoginEntity user = JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preLoginUser));

  static Future uploadFile(File image, Type type) async {
    try {
      String fileName;
      if (type == Type.LICENCE) {
        fileName = 'imgLicence';
      } else if (type == Type.DRIVER) {
        fileName = 'imgDriver';
      } else if (type == Type.CERTIFICATE) {
        fileName = 'imgCertificate';
      }
      String path = 'driverdocuments/' + user.email ?? "Unknown";
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
          var vehicle = VehicleEntity().fromJson(doc.data);
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

  static Future addDriverInfo(DriverInfoEntity data) async {
    data.driver_status = "0";
    data.uid = user.uid;
    await driverInfoCollection.document(user.uid).setData(data.toJson());
    return;
  }

  static Future updateDriverInfo(DriverInfoEntity data) async {
    await driverInfoCollection.document(user.uid).updateData(data.toJson());
    return;
  }

  static Future addDriverOffer(DriverOfferEntity data) async {
    /*data.uid = user.uid;
    var driverOffer = driverOfferCollection.document(user.uid);
    await driverOffer.get().then(
      (value) {
        printLog('addDriverOffer=' + value.data.toString());
        if (value.data == null) {
          data.created_at = DateTime.now();
          driverOffer.setData(data.toJson());
        } else {
          driverOffer.updateData(data.toJson());
        }
      },
    );*/
    final CollectionReference driverOfferCollection = Firestore.instance.collection('driverOffer');
    data.uid = user.uid;
    data.created_at = DateTime.now();
    data.customer_id = user.customer_id;
    printLog(data.toString());
    driverOfferCollection.add(data.toJson());
    return;
  }

  static Future addRequestPool(RequestInfo data) async {
    CollectionReference requestCollection = Firestore.instance.collection('requestPool');
    data.created_at = DateTime.now();
    data.customer_id = user.customer_id;
    printLog(data.toString());
    requestCollection.add(data.toJson());
    return;
  }

  static void printLog(dynamic data) {
    BaseRepository.logger.e(data);
  }
}

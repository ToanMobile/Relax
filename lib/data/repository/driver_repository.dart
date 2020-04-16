import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';
import 'package:relax/ui/screen/capture/capture_page.dart';
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
      String path = user.name ?? "Unknown";
      StorageReference storageReference = FirebaseStorage.instance.ref().child('$path/$fileName');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      var url = await (await uploadTask.onComplete).ref.getDownloadURL();
      return url;
    } catch (e) {
      printLog(e);
      return null;
    }
  }

  static void printLog(dynamic data) {
    BaseRepository.logger.e(data);
  }
}

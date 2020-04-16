import 'dart:io';
import 'dart:math';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/data/model/driver_entity.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/repository/driver_repository.dart';
import 'package:relax/data/repository/map_repository.dart';
import 'package:relax/lib/res/utils.dart';
import 'package:relax/provider/view_state_model.dart';
import 'package:relax/ui/screen/capture/capture_page.dart';

class DriverModel extends ViewStateModel {
  List<PlaceItemRes> _items = List();

  List<PlaceItemRes> get items => _items;

  Future searchPlace(String keyword) async {
    if (keyword.length > 0) {
      setBusy();
      try {
        _items = await MapRepository.searchPlace(keyword);
        setIdle();
      } catch (e, s) {
        setError(e, s);
      }
    }
  }

  Future<String> uploadFile(File image, Type type) async {
    try {
      setBusy();
      var url = await DriverRepository.uploadFile(image, type);
      print('File Uploaded=$url');
      setIdle();
      return url;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }

  Future<bool> sendEmail(String _email) async {
    if (_email.length > 0) {
      setBusy();
      try {
        final random = Random();
        Constant.check_code = random.nextIntOfDigits(6);
        final Email email = Email(
          body: Constant.check_code.toString(),
          subject: 'Relax Code',
          recipients: [_email]
        );
        await FlutterEmailSender.send(email);
        setIdle();
        return true;
      } catch (e, s) {
        setError(e, s);
      }
    }
    return false;
  }

  Future<bool> checkCode(String code) async {
    print('check_code=' +Constant.check_code.toString());
    print('code=' +code);
    if (code.length > 0) {
      setBusy();
      if (code.trim() == Constant.check_code.toString()) {
        setIdle();
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> addDriver(DriverEntity driverEntity) async {
    setBusy();
    try {
      await DriverRepository.addDriver(driverEntity);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<bool> updateDriver(DriverEntity driverEntity) async {
    setBusy();
    try {
      await DriverRepository.updateDriver(driverEntity);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}

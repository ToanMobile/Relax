import 'dart:io';

import 'package:flutter/material.dart';
import 'package:relax/config/storage_manager.dart';
import 'package:relax/data/model/driver_info_entity.dart';
import 'package:relax/data/model/driver_offer_entity.dart';
import 'package:relax/data/model/login_entity.dart';
import 'package:relax/data/model/request_info_entity.dart';
import 'package:relax/data/model/verhicle_entity.dart';
import 'package:relax/data/repository/driver_repository.dart';
import 'package:relax/data/repository/login_register_repository.dart';
import 'package:relax/generated/json/base/json_convert_content.dart';
import 'package:relax/provider/view_state_model.dart';
import 'package:relax/ui/screen/map/driver/capture/capture_page.dart';

import 'login_model.dart';

class DriverModel extends ViewStateModel {
  LoginEntity get getUser => JsonConvert.fromJsonAsT(StorageManager.getObject(LoginModel.preLoginUser)) ?? LoginEntity();

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

  Future<bool> sendOtp(String numberPhone) async {
    if (numberPhone.length > 0) {
      setBusy();
      try {
        await LoginRegisterRepository.sendOtp(numberPhone);
        setIdle();
        return true;
      } catch (e, s) {
        setError(e, s);
      }
    }
    return false;
  }

  Future<bool> checkCode(String otp) async {
    setBusy();
    try {
      await LoginRegisterRepository.verifyOtp(otp);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
    }
    return false;
  }

  Future<bool> addDriverInfo(DriverInfoEntity driverEntity) async {
    setBusy();
    try {
      await DriverRepository.addDriverInfo(driverEntity);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<bool> addDriverOffer(DriverOfferEntity driverEntity) async {
    setBusy();
    try {
      await DriverRepository.addDriverOffer(driverEntity);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<bool> addRequestPool(RequestInfo requestInfo) async {
    setBusy();
    try {
      await DriverRepository.addRequestPool(requestInfo);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<List<DropdownMenuItem<VehicleEntity>>> getListVehicles() async {
    setBusy();
    try {
      var list = await DriverRepository.getListVehicles();
      setIdle();
      return list;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }
}

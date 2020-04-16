import 'dart:io';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/repository/driver_repository.dart';
import 'package:relax/data/repository/map_repository.dart';
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

  Future sendEmail(String email) async {
    if (email.length > 0) {
      setBusy();
      try {
        _items = await MapRepository.searchPlace(email);
        setIdle();
        notifyListeners();
      } catch (e, s) {
        setError(e, s);
      }
    }
  }
}

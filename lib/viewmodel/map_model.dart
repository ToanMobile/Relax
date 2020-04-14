import 'dart:collection';

import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/repository/map_repository.dart';
import 'package:relax/provider/view_state_model.dart';

class MapModel extends ViewStateModel {
  final List<PlaceItemRes> _items = [];
  UnmodifiableListView<PlaceItemRes> get items => UnmodifiableListView(_items);

  Future<bool> searchPlace(keyword) async {
    setBusy();
    try {
      await MapRepository.searchPlace(keyword).then((value) => _items.addAll(value));
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}

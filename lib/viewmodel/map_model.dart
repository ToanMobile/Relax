import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/data/repository/map_repository.dart';
import 'package:relax/provider/view_state_model.dart';

class MapModel extends ViewStateModel {
  List<PlaceItemRes> _items = List();

  List<PlaceItemRes> get items => _items;

  Future searchPlace(String keyword) async {
    if (keyword.length > 0) {
      setBusy();
      try {
        _items = await MapRepository.searchPlace(keyword);
        setIdle();
        notifyListeners();
      } catch (e, s) {
        setError(e, s);
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/provider/view_state_widget.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/ui/widget/button_progress_indicator.dart';
import 'package:relax/ui/widget/text_input_search.dart';
import 'package:relax/viewmodel/map_model.dart';

class RidePickerPage extends StatefulWidget {
  final String selectedAddress;
  final Function(PlaceItemRes, bool) onSelected;
  final bool _isFromAddress;

  RidePickerPage(this.selectedAddress, this.onSelected, this._isFromAddress);

  @override
  _RidePickerPageState createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<RidePickerPage> {
  var _addressController;

  @override
  void initState() {
    _addressController = TextEditingController(text: widget.selectedAddress);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ViewModelProvider<MapModel>.withConsumer(
        viewModel: MapModel(),
        onModelReady: (model) {
          _addressController.text = widget.selectedAddress;
          model.searchPlace(_addressController.text);
        },
        builder: (context, model, child) {
          Widget widgetChild;
          if (model.busy) {
            widgetChild = Container(
              height: 150.h,
              child: Center(
                child: ButtonProgressIndicator(color: ColorsUtils.coralPink,),
              ),
            );
          } else if (model.error && model.items.isEmpty) {
            widgetChild = ViewStateErrorWidget(error: model.viewStateError, onPressed: () {});
          } else if (model.empty) {
            widgetChild = ViewStateEmptyWidget(onPressed: () {});
          } else {
            widgetChild = Expanded(
              flex: 1,
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        model.items.elementAt(index).name == null ? '' : model.items.elementAt(index).name,
                        style: TextStylesUtils.styleRegular14BlackW400,
                      ),
                      subtitle: Text(model.items.elementAt(index).address == null ? '' : model.items.elementAt(index).address,
                          style: TextStylesUtils.styleRegular12BrownGreyW400),
                      onTap: () {
                        print("on tap");
                        Navigator.of(context).pop();
                        widget.onSelected(model.items.elementAt(index), widget._isFromAddress);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Color(0xfff5f5f5),
                      ),
                  itemCount: model.items.length),
            );
          }
          return Container(
            constraints: BoxConstraints.expand(),
            color: Color(0xfff8f8f8),
            child: Column(
              children: <Widget>[
                buildSearchView(model),
                widgetChild,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchView(MapModel mapModel) => TextInputSearch(
        validateErrMsg: "",
        controller: _addressController,
        cb: () {
          mapModel.searchPlace(_addressController.text);
        },
      );
}

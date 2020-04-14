import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:relax/data/model/place_item_res.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:relax/res/image.dart';
import 'package:relax/ui/widget/button_progress_indicator.dart';
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
      body: ViewModelProvider<MapModel>.withoutConsumer(
        viewModel: MapModel(),
        onModelReady: (model) => {},
        builder: (context, model, child) {
          Widget childWidget = model.busy
              ? Container(
                  height: 150.h,
                  child: Center(
                    child: ButtonProgressIndicator(),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(model.items.elementAt(index).name == null ? '' : model.items.elementAt(index).name),
                          subtitle: Text(model.items.elementAt(index).address == null ? '' : model.items.elementAt(index).address),
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
          return Container(
            constraints: BoxConstraints.expand(),
            color: Color(0xfff8f8f8),
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: <Widget>[
                          SizedBox(
                            width: 40,
                            height: 60,
                            child: Center(
                              child: Image.asset(ImagesUtils.iconLocation),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            width: 40,
                            height: 60,
                            child: Center(
                              child: FlatButton(
                                  onPressed: () {
                                    _addressController.text = "";
                                  },
                                  child: Image.asset(ImagesUtils.iconClose)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 40, right: 50),
                            child: TextField(
                              controller: _addressController,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (str) {
                                model.searchPlace(str);
                              },
                              style: TextStyle(fontSize: 16, color: Color(0xff323643)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                childWidget,
              ],
            ),
          );
        },
      ),
    );
  }
}

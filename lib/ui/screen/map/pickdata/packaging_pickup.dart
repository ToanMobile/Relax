import 'package:flutter/material.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/res/image.dart';

class PackagingPickup extends StatefulWidget {
  final Function(PackagingItem) onPackagingSelected;

  PackagingPickup(this.onPackagingSelected);

  @override
  _PackagingPickupState createState() => _PackagingPickupState();
}

class PackagingItem {
  final String name;
  final String assetsName; // name of picture in asset
  final double pricePerKM;

  PackagingItem(this.name, this.assetsName, this.pricePerKM);
}

class PackagingList {
  static List<PackagingItem> list;

  static List<PackagingItem> getPackagingList(BuildContext context) {
    if (list != null) {
      return list;
    }
    list = new List();
    list.add(PackagingItem(S.of(context).small_parcel, "${ImagesUtils.imageIcon}/ic_pickup_sedan.png", 0.8));
    list.add(PackagingItem(S.of(context).normal_parcel, "${ImagesUtils.imageIcon}/ic_pickup_van.png", 1.0));
    list.add(PackagingItem(S.of(context).big_parcel, "${ImagesUtils.imageIcon}/ic_pickup_suv.png", 1.2));
    list.add(PackagingItem(S.of(context).euro_pallet, "${ImagesUtils.imageIcon}/ic_radio.png", 2.5));
    list.add(PackagingItem(S.of(context).lattice, "${ImagesUtils.imageIcon}/ic_pickup_hatchback.png", 3));
    list.add(PackagingItem(S.of(context).individual, "${ImagesUtils.imageIcon}/ic_radio_checked.png", 1.5));
    return list;
  }
}

class _PackagingPickupState extends State<PackagingPickup> {
  @override
  Widget build(BuildContext context) {
    PackagingList();
    final packagingItems = PackagingList.getPackagingList(context);
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(backgroundColor: Colors.brown[400], elevation: 0.0, title: Text('select one packaging')),
      body: Container(
        child: ListView.builder(
          itemCount: packagingItems.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Card(
                child: Container(
                    width: double.infinity,
                    height: 65,
                    child: FlatButton(
                        onPressed: () {
                          print("on click");
                          Navigator.of(context).pop();
                          widget.onPackagingSelected(packagingItems.elementAt(index));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: ColorsUtils.offWhite,
                            child: Image.asset(packagingItems.elementAt(index).assetsName),
                          ),
                          title: Text(
                            packagingItems.elementAt(index).name,
                            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
                          ),
                          subtitle: Text(
                            packagingItems.elementAt(index).pricePerKM.toString() + ' Eur/km',
                            style: TextStyle(fontSize: 14, color: Color(0xff323643)),
                          ),
                        ))),
              ),
            );
          },
        ),
      ),
    );
  }
}

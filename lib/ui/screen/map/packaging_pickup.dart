import 'package:flutter/material.dart';

class PackagingPickup extends StatefulWidget {
  final Function(PackagingItem) onPackagingselected;
  PackagingPickup(this.onPackagingselected);
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
  static List<PackagingItem> getPackagingList() {
    if(list != null) {
      return list;
    }
    list = new List();
    list.add(PackagingItem("small parcel", "ic_pickup_sedan.png", 0.8));
    list.add(PackagingItem("normal parcel", "ic_pickup_van.png", 1.0));
    list.add(PackagingItem("big parcel", "ic_pickup_suv.png", 1.2));
    list.add(PackagingItem("Euro pallet", "ic_radio.png", 2.5));
    list.add(PackagingItem("lattice box", "ic_pickup_hatchback.png", 3));
    list.add(PackagingItem("individual", "ic_radio_checked.png", 1.5));
    return list;
  }
}

class _PackagingPickupState extends State<PackagingPickup> {
  @override
  Widget build(BuildContext context) {
    PackagingList();
    final PackagingItems = PackagingList.getPackagingList();
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title:  Text('select one packaging')
      ),
      body: Container(
            child:  ListView.builder(
                itemCount: PackagingItems.length,
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
                              widget.onPackagingselected(PackagingItems.elementAt(index));             
                            },              
                          child: ListTile(          
                            leading: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.brown[200],
                            backgroundImage: AssetImage(PackagingItems.elementAt(index).assetsName),
                            ), 
                            title: Text(PackagingItems.elementAt(index).name,
                                  style: TextStyle(fontSize: 18, color: Color(0xff323643)),),
                            subtitle: Text(PackagingItems.elementAt(index).pricePerKM.toString() + ' Eur/km',
                                  style: TextStyle(fontSize: 14, color: Color(0xff323643)),),
                          )
                        )
                        ),
                      ), 
                    );   
                })

    )
    );       
  }
}
import 'package:flutter/material.dart';
import 'package:relax/res/colors.dart';

import '../icon/custome_icon.dart';

//COLORS
const Color profile_info_background = ColorsUtils.salmon;
const Color profile_info_categories_background = Color(0xFFF6F5F8);
const Color profile_info_address = Color(0xFF8D7AEE);
const Color profile_info_privacy = Color(0xFFF369B7);
const Color profile_info_general = Color(0xFFFFC85B);
const Color profile_info_notification = Color(0xFF5DD1D3);
const Color profile_item_color = Color(0xFFC4C5C9);
const String imagePath = 'assets/image';

const String devMausam = 'https://image.flaticon.com/icons/svg/727/727399.svg';

const Color furnitureCateDisableColor = Color(0xFF939BA9);
const List lampsImage = [
  {'image': 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fa.jpg?alt=media&token=6af6cfed-84a6-4cf3-a5ce-875fe47f8c5b'},
  {'image': 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fb.jpg?alt=media&token=801b2f22-94fd-419b-8b84-c9b4fbd45d4d'},
  {'image': 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fc.jpg?alt=media&token=b4470e0b-411f-4925-acaf-d6cb9292a44e'},
  {'image': 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fd.jpg?alt=media&token=01ed6f8d-8e1d-403a-a5a0-423b7aa958be'},
  {'image': 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Fe.jpg?alt=media&token=a9342ee6-9dc6-452d-ade7-4a1d7783e7fe'},
  {'image': 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/mausam%2Ff.jpg?alt=media&token=c65c13ad-5b2f-494e-82eb-13d730d823ce'},
];
List<ProfileModel> lampList = [
  ProfileModel(title: 'Landscape', subTitle: '384'),
  ProfileModel(title: 'Discus Pendant', subTitle: '274'),
  ProfileModel(title: 'Mushroom Lamp', subTitle: '374'),
  ProfileModel(title: 'Titanic Pendant', subTitle: '562'),
  ProfileModel(title: 'Torn Lighting', subTitle: '105'),
  ProfileModel(title: 'Abduction Pendant', subTitle: '365'),
];
List<FurnitureCatg> furnitureCategoriesList = [
  FurnitureCatg(icon: Icons.desktop_windows, elivation: true),
  FurnitureCatg(icon: CustomIcon.account_balance_wallet, elivation: false),
  FurnitureCatg(icon: Icons.security, elivation: false),
  FurnitureCatg(icon: CustomIcon.chat, elivation: false),
  FurnitureCatg(icon: CustomIcon.money, elivation: false),
];

class ProfileModel {
  String title;
  String subTitle;
  IconData icon;
  Color iconColor;
  ProfileModel({this.icon, this.title, this.iconColor, this.subTitle});
}

class Catg {
  String name;
  IconData icon;
  int number;
  Catg({this.icon, this.name, this.number});
}

class FurnitureCatg {
  IconData icon;
  bool elivation;
  FurnitureCatg({this.icon, this.elivation});
}

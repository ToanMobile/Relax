import 'package:relax/data/model/show_entity.dart';
import 'package:relax/lib/screenutils/flutter_screenutil.dart';
import 'package:relax/res/image.dart';
import 'package:relax/ui/screen/widget/container_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:relax/res/colors.dart';
import 'package:relax/res/text_styles.dart';
import 'package:relax/lib/screenutils/size_extension.dart';
import 'package:flutter_svg/svg.dart';

class ShowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShowState();
}

class ShowState extends State<ShowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildListCategory(),
          buildDetails(),
          buildListData(),
        ],
      ),
    );
  }

  final listCategory = ["All", "Action", "Comedy", "Drama", "Family", "Documentary"];

  final listData = List<ShowEntity>.generate(
      100,
      (index) => (index % 2 == 0
          ? ShowEntity("Chipu",
              "https://images.pexels.com/photos/147411/italy-mountains-dawn-daybreak-147411.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260")
          : ShowEntity("Midu",
              "https://images.pexels.com/photos/39811/pexels-photo-39811.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260")));

  Widget buildListCategory() => Container(
        height: 150.h,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemExtent: ScreenUtil.screenWidthDp / listCategory.length,
            itemCount: listCategory.length,
            itemBuilder: (context, position) {
              return ContainerButton(
                isExpanded: true,
                title: listCategory[position].toUpperCase(),
                bgColor: ColorsUtils.menuCategory,
                bgColorFocus: ColorsUtils.menuSelect,
                textStyle: TextStylesUtils().styleMedium18Black,
                textStyleFocus: TextStylesUtils().styleMedium18White,
              );
            }),
      );

  Widget buildDetails() => Expanded(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorsUtils.brownishGrey,
          child: SvgPicture.asset(
            ImagesUtils.iconInfo,
          ),
        ),
        flex: 1,
      );

  Widget buildListData() => Container(
        height: 500.h,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listData.length,
            itemBuilder: (context, position) {
              return Column(
                children: [
                  CachedNetworkImage(
                    width: 200.w,
                    height: 400.h,
                    imageUrl: listData[position].url,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Text(
                    listData[position].title,
                    style: TextStylesUtils().styleRegular20TextSelect,
                  )
                ],
              );
            }),
      );
}

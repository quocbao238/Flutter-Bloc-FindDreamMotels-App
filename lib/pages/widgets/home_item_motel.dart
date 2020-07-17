import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:flutter/material.dart';

import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class HomeMotelItem extends StatelessWidget {
  final MotelModel motelModel;
  final Function onTap;
  const HomeMotelItem(this.motelModel, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (!ConfigApp.drawerShow) {
        //   BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
        //       .add(OnClickListMotelssEvent(index));
        // }
        if (onTap != null) onTap();
      },
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        padding: EdgeInsets.only(left: 12.0, bottom: 12.0),
        width: Size.getWidth * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          image: DecorationImage(
              image: NetworkImage(AppSetting.imageTest), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              motelModel.title,
              maxLines: 1,
              style: StyleText.header20Whitew500,
            ),
            SizedBox(height: 8.0),
            Text(
              motelModel.address,
              maxLines: 1,
              style: StyleText.content14White60w400,
            ),
            SizedBox(height: 8.0),
            SmoothStarRating(
              rating: motelModel.rating,
              isReadOnly: false,
              size: 24.0,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              starCount: 5,
              allowHalfRating: true,
              spacing: 2.0,
              onRated: (value) {},
              color: Colors.yellow,
              borderColor: Colors.yellow[100],
            )
          ],
        ),
      ),
    );
  }
}

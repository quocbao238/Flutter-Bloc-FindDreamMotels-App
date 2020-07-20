import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:findingmotels/pages/new_motel/bloc/newmotel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

class FavoriteItem extends StatelessWidget {
  final MotelModel motelModel;
  final int index;
  final Function onTapImage;
  final Function onTapCall;
  final Function onTapMessage;
  final Function onTapDirect;

  FavoriteItem({
    this.index,
    this.onTapImage,
    this.onTapCall,
    this.onTapMessage,
    this.onTapDirect,
    this.motelModel,
  });

  @override
  Widget build(BuildContext context) {
    return _item();
  }

  Widget _item() => Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(index == 0 ? 30.0 : 0.0)),
          color: AppColor.backgroundColor,
        ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: AppColor.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_itemImage(), _itemContent()],
          ),
        ),
      );

  Widget _itemImage() {
    return InkWell(
      onTap: () {
        if (onTapImage != null) onTapImage();
      },
      child: Container(
        height: 120.0,
        width: 120.0,
        margin: EdgeInsets.only(right: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: CachedNetworkImage(
              imageUrl: motelModel.imageMotel[0].imageUrl,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                            color: index.isEven ? Colors.red : Colors.green),
                      );
                    },
                  )),
              errorWidget: (context, url, error) => Container(
                    // color: Colors.red,
                    child: Center(
                      child: SvgPicture.asset(
                        AppSetting.logoIcon,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
        ),
      ),
    );
  }

  Widget _itemContent() => Expanded(
        child: Container(
          height: 120.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                // "Cheap motel room",
                motelModel.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleText.subhead16Black500,
              ),
              SizedBox(height: 8.0),
              Text(
                districList[motelModel.districtId] + ", Ho Chi Minh, Viet Nam",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleText.content14Black400,
              ),
              SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Text(
                    '${motelModel.price}\$',
                    style: StyleText.price20Red,
                  ),
                  SizedBox(width: 16.0),
                  Spacer(),
                  FlutterRatingBar(
                    itemSize: 16.0,
                    initialRating: motelModel.rating,
                    onRatingUpdate: (v) {},
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '${Random().nextInt(5000)} reviews',
                    textAlign: TextAlign.center,
                    style: StyleText.content14Black400,
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              _itemButton()
            ],
          ),
        ),
      );

  Widget _itemButton() => Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: _iconfunction(
              onTap: () {
                if (onTapCall != null) onTapCall();
              },
              icondata: Icons.call,
            )),
            Expanded(
                child: _iconfunction(
              onTap: () {
                if (onTapMessage != null) onTapMessage();
              },
              icondata: Icons.message,
            )),
            Expanded(
                child: _iconfunction(
              onTap: () {
                if (onTapDirect != null) onTapDirect();
              },
              icondata: Icons.directions,
            )),
          ],
        ),
      );

  Widget _iconfunction({Function onTap, IconData icondata}) {
    return InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Container(
            alignment: Alignment.centerLeft,
            child: Icon(icondata, color: AppColor.colorClipPath)));
  }
}

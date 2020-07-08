import 'package:cached_network_image/cached_network_image.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class FavoriteItem extends StatelessWidget {
  final int index;
  final Function onTapCall;
  final Function onTapMessaga;
  final Function onTapDirect;
  final String imageUrl;
  final String title;
  final String address;
  final int pricce;
  final double rating;

  FavoriteItem(
      {this.onTapCall,
      this.index,
      this.imageUrl,
      this.onTapMessaga,
      this.onTapDirect,
      this.title,
      this.address,
      this.pricce,
      this.rating});

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
    return Container(
      height: 120.0,
      width: 120.0,
      margin: EdgeInsets.only(right: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                  child: LoadingWidget(),
                ),
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
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleText.subhead16Black500,
              ),
              SizedBox(height: 8.0),
              Text(
                // "Alley 60 - Cach Mang Thang Tam, Ward 6, District 3, Ho Chi Minh 21321 3213 21321312321 321 3213 21",
                address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: StyleText.content14Black400,
              ),
              SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Text(
                    '$pricce\$',
                    style: StyleText.price20Red,
                  ),
                  Spacer(),
                  FlutterRatingBar(
                    itemSize: 24.0,
                    initialRating: rating,
                    onRatingUpdate: (v) {},
                  )
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
                if (onTapMessaga != null) onTapMessaga();
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

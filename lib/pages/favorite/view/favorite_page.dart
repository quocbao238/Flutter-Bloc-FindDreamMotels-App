import 'package:cached_network_image/cached_network_image.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/favorite/bloc/favorite_bloc.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  GlobalKey globalKey;

  @override
  void initState() {
    globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FavoriteBloc(),
        child: BlocListener<FavoriteBloc, FavoriteState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) => _scaffold())));
  }

  void blocListener(FavoriteState state, BuildContext context) {}

  Widget _scaffold() => Scaffold(
        key: globalKey,
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.colorClipPath,
          title: Text(
            'Favorite Motels',
            style: StyleText.header20Whitew500,
          ),
        ),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 160.0,
                              width: 160.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: CachedNetworkImage(
                                    imageUrl: AppSetting.imageTest,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                              child: LoadingWidget(),
                                            ),
                                    errorWidget: (context, url, error) =>
                                        Container(
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
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Container(
                                height: 160.0,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Cheap motel room",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleText.header20Black,
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      "Alley 60 - Cach Mang Thang Tam, Ward 6, District 3, Ho Chi Minh 21321 3213 21321312321 321 3213 21",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleText.content14Black400,
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '68\$',
                                          style: StyleText.price24Red,
                                        ),
                                        Spacer(),
                                        FlutterRatingBar(
                                          itemSize: 24.0,
                                          initialRating: 3.5,
                                          onRatingUpdate: (v) {},
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        IconButton(
                                          iconSize: 34.0,
                                          color: AppColor.colorClipPath,
                                          icon: Icon(Icons.call),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          iconSize: 34.0,
                                          color: AppColor.colorClipPath,
                                          icon: Icon(Icons.message),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          iconSize: 34.0,
                                          color: AppColor.colorClipPath,
                                          icon: Icon(Icons.directions),
                                          onPressed: () {},
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ))),
        ),
      );
}

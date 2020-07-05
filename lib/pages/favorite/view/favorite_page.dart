import 'package:cached_network_image/cached_network_image.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/favorite/bloc/favorite_bloc.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: 20,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 120.0,
                              width: 120.0,
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
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: <Widget>[
                            //     Text(
                            //       "Cheap motel room",
                            //       maxLines: 1,
                                  // overflow: TextOverflow.ellipsis,
                            //       style: StyleText.header24Black,
                            //     ),
                            //     SizedBox(height: 8.0),
                            //     Text(
                            //       "Alley 60 - Cach Mang Thang Tam, Ward 6, District 3, Ho Chi Minh",
                            //       maxLines: 2,
                            //       // overflow: TextOverflow.ellipsis,
                            //       style: StyleText.subhead16Black500,
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ))),
        ),
      );
}


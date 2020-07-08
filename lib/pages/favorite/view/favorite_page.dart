import 'package:cached_network_image/cached_network_image.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/favorite/bloc/favorite_bloc.dart';
import 'package:findingmotels/widgets/clip_path_custom/loginClipPath.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
        body: Stack(
          children: <Widget>[buildBackground(0.1), _body()],
        ),
      );

  Widget _body() => Positioned.fill(
        child: Column(
          children: <Widget>[
            _appBar(),
            _content(),
          ],
        ),
      );

  Widget _content() => Expanded(
        child: ListView.builder(
          itemCount: 10,  
          shrinkWrap: true,
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
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
                              (context, url, downloadProgress) => Center(
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
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Container(
                      height: 120.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Cheap motel room",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleText.subhead16Black500,
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
                                style: StyleText.price20Red,
                              ),
                              Spacer(),
                              FlutterRatingBar(
                                itemSize: 24.0,
                                initialRating: 3.5,
                                onRatingUpdate: (v) {},
                              )
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(Icons.call,
                                                color:
                                                    AppColor.colorClipPath)))),
                                Expanded(
                                    child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(Icons.message,
                                                color:
                                                    AppColor.colorClipPath)))),
                                Expanded(
                                    child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(Icons.directions,
                                                color:
                                                    AppColor.colorClipPath)))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget _appBar() => Container(
        padding: EdgeInsets.only(top: 16.0),
        margin: EdgeInsets.only(bottom: Size.getHeight * 0.02),
        child: Text('Favorite Motels',
            textAlign: TextAlign.center,
            style: GoogleFonts.vidaloka(
                color: Colors.white, fontSize: 24 * Size.scaleTxt)),
      );

  Widget buildBackground(double height) => Positioned.fill(
        child: ClipPath(
          child: Container(
            color: AppColor.colorClipPath,
          ),
          clipper: HomeClipPath(height),
        ),
      );
}

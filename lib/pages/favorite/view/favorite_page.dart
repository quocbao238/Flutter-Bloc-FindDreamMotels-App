
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/favorite/bloc/favorite_bloc.dart';
import 'package:findingmotels/pages/widgets/favorite_item.dart';
import 'package:findingmotels/widgets/clip_path_custom/loginClipPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          children: <Widget>[buildBackground(0.13), _body()],
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
          itemBuilder: (context, index) => FavoriteItem(
            index: index,
            imageUrl: AppSetting.imageTest,
            address:
                "Alley 60 - Cach Mang Thang Tam, Ward 6, District 3, Ho Chi Minh 21321 3213 21321312321 321 3213 21",
            pricce: 68,
            rating: 4.2,
            title: "Cheap motel room",
            onTapCall: () {},
            onTapMessaga: () {},
            onTapDirect: () {},
          ),
        ),
      );

  Widget _appBar() => Container(
        padding: EdgeInsets.only(top: 32.0),
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

import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:findingmotels/pages/favorite/bloc/favorite_bloc.dart';
import 'package:findingmotels/pages/motel_detail/view/motel_detail_page.dart';
import 'package:findingmotels/pages/widgets/favorite_item.dart';
import 'package:findingmotels/widgets/clip_path_custom/loginClipPath.dart';
import 'package:findingmotels/widgets/empty/empty_widget.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  GlobalKey globalKey;
  List<MotelModel> listFavoriteMotels;
  bool isHaveData = false;

  @override
  void initState() {
    listFavoriteMotels = [];
    globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FavoriteBloc()..add(FeatchFavoriteListEvent()),
        child: BlocListener<FavoriteBloc, FavoriteState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) => Stack(
                      children: <Widget>[
                        _scaffold(state),
                        state is FavoriteLoadingState
                            ? LoadingWidget()
                            : SizedBox()
                      ],
                    ))));
  }

  void blocListener(FavoriteState state, BuildContext context) async {
    if (state is FeatchFavoriteListSucessState) {
      listFavoriteMotels = state.listMotel;
      isHaveData = true;
    } else if (state is GoToDetailState) {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MotelDetailPage(motelModel: state.motelModel))).then((v) {
        BlocProvider.of<FavoriteBloc>(globalKey.currentContext)
            .add(FeatchFavoriteListEvent());
      });
    }
  }

  Widget _scaffold(FavoriteState state) => Scaffold(
        key: globalKey,
        backgroundColor: AppColor.backgroundColor,
        body: Stack(
          children: <Widget>[buildBackground(0.12), _body(state)],
        ),
      );

  Widget _body(FavoriteState state) => Positioned.fill(
        child: Column(
          children: <Widget>[
            _appBar(),
            _content(state),
          ],
        ),
      );

  Widget _content(FavoriteState state) => Expanded(
      child: listFavoriteMotels.length > 0
          ? ListView.builder(
              itemCount: listFavoriteMotels.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => FavoriteItem(
                motelModel: listFavoriteMotels[index],
                index: index,
                onTapImage: () {
                  BlocProvider.of<FavoriteBloc>(globalKey.currentContext)
                      .add(GoToDetailEvent(listFavoriteMotels[index]));
                },
                onTapCall: () {},
                onTapMessage: () {},
                onTapDirect: () {},
              ),
            )
          : isHaveData ? Expanded(child: EmptyWidget()) : SizedBox());

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

import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/models/district_model.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:findingmotels/pages/districtdetail/bloc/districtdetail_bloc.dart';
import 'package:findingmotels/pages/map/moteldirection.dart';
import 'package:findingmotels/pages/motel_detail/view/motel_detail_page.dart';
import 'package:findingmotels/pages/widgets/empty/empty_widget.dart';
import 'package:findingmotels/pages/widgets/favorite_item.dart';
import 'package:findingmotels/pages/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DistrictDetail extends StatefulWidget {
  final DistrictModel districtModel;
  const DistrictDetail({this.districtModel});
  @override
  _DistrictDetailState createState() => _DistrictDetailState();
}

class _DistrictDetailState extends State<DistrictDetail> {
  GlobalKey globalKey;
  bool isHaveData = false;
  List<MotelModel> listMotel;
  @override
  void initState() {
    listMotel = [];
    globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DistrictdetailBloc()
          ..add(FeatchMotelDistrict(widget.districtModel.districtId)),
        child: BlocListener<DistrictdetailBloc, DistrictdetailState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<DistrictdetailBloc, DistrictdetailState>(
                builder: (context, state) => _scaffold(state))));
  }

  Future<void> blocListener(
      DistrictdetailState state, BuildContext context) async {
    if (state is FeatchDistrictMotelSucessState) {
      listMotel = state.list;
      isHaveData = true;
    } else if (state is GoToDetailState) {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MotelDetailPage(motelModel: state.motelModel)));
    } else if (state is OnTapDirectionState) {
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context) {
            return MapMotelDirection(motelModel: state.motelModel);
          },
        ),
      );
    }
  }

  Widget _scaffold(DistrictdetailState state) => Scaffold(
        key: globalKey,
        backgroundColor: AppColor.backgroundColor,
        body: Stack(
          children: <Widget>[
            _body(state),
            state is LoadingDistrictDetail ? LoadingWidget() : SizedBox(),
          ],
        ),
      );

  Widget _body(DistrictdetailState state) => Column(
        children: <Widget>[
          _appBar(),
          _content(state),
        ],
      );

  Widget _content(DistrictdetailState state) => Expanded(
      child: listMotel.length > 0
          ? ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: listMotel.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => FavoriteItem(
                motelModel: listMotel[index],
                index: index,
                onTapImage: () {
                  BlocProvider.of<DistrictdetailBloc>(globalKey.currentContext)
                      .add(GoToDetailEvent(listMotel[index]));
                },
                onTapCall: () {},
                onTapMessage: () {},
                onTapDirect: () {
                  BlocProvider.of<DistrictdetailBloc>(globalKey.currentContext)
                      .add(OnTapDirectionEvent(listMotel[index]));
                },
              ),
            )
          : isHaveData ? EmptyWidget() : SizedBox());

  Widget _appBar() => Container(
        padding: EdgeInsets.only(top: 32.0, left: 10, right: 10),
        height: Size.getHeight * 0.12,
        width: Size.getWidth,
        color: AppColor.colorClipPath,
        margin: EdgeInsets.only(bottom: Size.getHeight * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              child: Container(
                height: 30,
                width: 30,
                child: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Text(widget.districtModel.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.vidaloka(
                    color: Colors.white, fontSize: 24 * Size.scaleTxt)),
            Container(
              height: 30,
              width: 30,
              child: Icon(Icons.arrow_back, color: Colors.transparent),
            ),
          ],
        ),
      );
}

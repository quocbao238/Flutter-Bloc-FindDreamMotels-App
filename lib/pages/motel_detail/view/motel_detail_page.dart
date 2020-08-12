import 'dart:math';

import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/models/history_model.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:findingmotels/pages/map/moteldirection.dart';
import 'package:findingmotels/pages/motel_detail/bloc/motel_detail_bloc.dart';
import 'package:findingmotels/pages/widgets/reserve_tiem.dart';
import 'package:findingmotels/widgets/empty/empty_widget.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MotelDetailPage extends StatefulWidget {
  final MotelModel motelModel;
  MotelDetailPage({this.motelModel});
  @override
  _MotelDetailPageState createState() => _MotelDetailPageState();
}

class _MotelDetailPageState extends State<MotelDetailPage> {
  List<dynamic> images = [];
  GlobalKey globalKey;
  CameraPosition initialCameraPosition;
  bool _isFv = false;
  bool isShowBottomSheet;
  DetailBooking detailBooking;
  Set<Marker> _markers = {};

  @override
  void initState() {
    globalKey = GlobalKey();
    super.initState();
    for (var imgMotel in widget.motelModel.imageMotel) {
      images.add(CachedNetworkImage(
        imageUrl: imgMotel.imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(child: SpinKitFadingCircle(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green),
            );
          },
        )),
        errorWidget: (context, url, error) => Center(child: EmptyWidget()),
      ));
    }
    initialCameraPosition = CameraPosition(
      target: LatLng(
          widget.motelModel.location.lat, widget.motelModel.location.lng),
      zoom: 14.5,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMaker();
    });
    isShowBottomSheet = false;
    detailBooking = DetailBooking();
  }

  _asyncMaker() async {
    _markers.add(await ConfigApp.myGoogleMapService
        .setMakerIcon(context, widget.motelModel));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            MotelDetailBloc()..add(FeatchDataEvent(widget.motelModel)),
        child: BlocListener<MotelDetailBloc, MotelDetailState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<MotelDetailBloc, MotelDetailState>(
                builder: (context, state) => scaffold(state))));
  }

  void blocListener(MotelDetailState state, BuildContext context) {
    if (state is FeatchDataSucessState) {
      _isFv = state.isFv;
    } else if (state is OnTapFavoriteRemoveState) {
      _isFv = !state.isFv;
    } else if (state is OnTapFavoriteSucessState) {
      _isFv = state.isFv;
    } else if (state is OnTapMapState) {
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context) {
            return MapMotelDirection(motelModel: state.motelModel);
          },
        ),
      );
    }
  }

  Widget scaffold(MotelDetailState state) => Stack(
        children: <Widget>[
          Scaffold(
            key: globalKey,
            body: Stack(
              children: <Widget>[
                _pageView(),
                _buttonBack(),
              ],
            ),
          ),
          state is LoadingState ? LoadingWidget() : SizedBox(),
        ],
      );

  Widget _pageView() => Positioned.fill(
        child: Container(
          color: AppColor.backgroundColor.withOpacity(0.6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              __sliderImg(),
              __body(),
              // buildBottomCallandBooking(),
            ],
          ),
        ),
      );

  Widget __body() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
            top: Size.getHeight * 0.02,
            left: Size.getWidth * 0.02,
            right: Size.getWidth * 0.02,
            bottom: Size.getHeight * 0.02),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ___header(),
              ___padding(Size.getHeight * 0.01),
              ___rating(),
              ___padding(Size.getHeight * 0.02),
              ___title('Amenities'),
              ___padding(Size.getHeight * 0.01),
              ___listAmentites(),
              ___padding(Size.getHeight * 0.02),
              ___title('Description'),
              ___padding(Size.getHeight * 0.01),
              ___description(),
              ___padding(Size.getHeight * 0.02),
              ___location(),
              ___padding(Size.getHeight * 0.01),
              ___map(),
              ___reserve()
            ],
          ),
        ),
      ),
    );
  }

  Widget ___description() =>
      Text(widget.motelModel.description, style: StyleText.subhead16Black);

  Widget ___padding(double height) => SizedBox(height: height);

  Widget ___location() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Location',
          style: StyleText.header20BlackW500,
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<MotelDetailBloc>(globalKey.currentContext)
                .add(OnTapMapEvent(widget.motelModel));
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(6, 10, 16, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.colorClipPath.withOpacity(0.7),
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Entypo.location_pin,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Direction',
                    style: StyleText.header20White,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget ___map() => Container(
        height: Size.getHeight * 0.35,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            markers: _markers,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {},
          ),
        ),
      );

  Widget __sliderImg() => Container(
        height: Size.getHeight * 0.3,
        child: Carousel(
            boxFit: BoxFit.cover,
            autoplay: true,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 500),
            dotSize: 6.0,
            dotIncreasedColor: AppColor.colorClipPath,
            dotBgColor: Colors.transparent,
            dotPosition: DotPosition.bottomCenter,
            // dotVerticalPadding: 10.0,
            showIndicator: true,
            // indicatorBgPadding: 7.0,
            images: images),
      );

  Widget ___listAmentites() => Container(
        height: Size.getHeight * 0.12,
        width: Size.getWidth,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.motelModel.amenities.length,
          itemBuilder: (context, index) => ____itemAmentites(index),
        ),
      );

  Widget ____itemAmentites(index) => widget.motelModel.amenities[index].isHave
      ? Container(
          // width: Size.getWidth * 0.20,
          margin: EdgeInsets.only(right: Size.getWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: Size.getWidth * 0.1,
                height: Size.getWidth * 0.1,
                child: Center(
                  child: Image.asset(getIconFromListAmenities(
                      widget.motelModel.amenities[index].name)),
                ),
              ),
              SizedBox(height: Size.getHeight * 0.01),
              Flexible(
                child: Text(
                  StringUtils.capitalize(
                      widget.motelModel.amenities[index].name),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: StyleText.subhead16Black500,
                ),
              )
            ],
          ),
        )
      : SizedBox();

  Widget ___title(String title) => Text(
        title,
        style: StyleText.header20BlackW500,
      );
  Widget ___rating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 8.0),
        SmoothStarRating(
          rating: widget.motelModel.rating,
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
        ),
        SizedBox(width: 8.0),
        Text(
          '${Random().nextInt(5000)} reviews',
          textAlign: TextAlign.center,
          style: StyleText.subhead16Black500,
        ),
      ],
    );
  }

  Widget ___header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 4.0),
                child: Text(
                  widget.motelModel.title,
                  style: StyleText.header24Black,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget?.motelModel?.price ?? "",
                  maxLines: 1,
                  style: StyleText.header24GreenMixBlue,
                ),
                SizedBox(width: 4.0),
                Text(
                  "\$",
                  maxLines: 1,
                  style: StyleText.header24Red,
                ),
              ],
            )
          ],
        ),
        SizedBox(height: Size.getHeight * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 24.0,
                ),
              ],
            ),
            SizedBox(width: 4.0),
            Flexible(
              child: Text(
                widget?.motelModel?.address ?? "",
                maxLines: 3,
                style: StyleText.subhead16Red500,
              ),
            ),
            InkWell(
                onTap: () {
                  BlocProvider.of<MotelDetailBloc>(globalKey.currentContext)
                      .add(OnTapFavoriteEvent(
                    isFavorite: _isFv,
                    motel: widget.motelModel,
                  ));
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Center(
                    child: Icon(!_isFv ? Icons.favorite_border : Icons.favorite,
                        color: !_isFv ? AppColor.selectColor : Colors.red),
                  ),
                ))
          ],
        )
      ],
    );
  }

  Widget _buttonBack() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 0,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: 80.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Colors.grey.withOpacity(0.6),
          ),
          child: Center(
              child:
                  Icon(Icons.arrow_back_ios, size: 30.0, color: Colors.white)),
        ),
      ),
    );
  }

  Widget ___reserve() {
    return InkWell(
      onTap: () async {
        setState(() => isShowBottomSheet = true);
        await showCupertinoModalBottomSheet(
            expand: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context, scrollController) => ReserveModal(
                  scrollController: scrollController,
                  motelModel: widget.motelModel,
                  detailBooking: detailBooking,
                )).then((_detailBooking) {
          if (_detailBooking != null)
            setState(() {
              detailBooking = _detailBooking;
            });
        });
        setState(() => isShowBottomSheet = false);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Size.getHeight * 0.01, vertical: Size.getHeight * 0.02),
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColor.colorClipPath),
        child: Center(child: Text('Reserve', style: StyleText.header24BWhite)),
      ),
    );
  }
}

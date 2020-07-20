import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:findingmotels/pages/motel_detail/bloc/motel_detail_bloc.dart';
import 'package:findingmotels/widgets/empty/empty_widget.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MotelDescriptionPage extends StatefulWidget {
  final MotelModel motelModel;
  MotelDescriptionPage({this.motelModel});
  @override
  _MotelDescriptionPageState createState() => _MotelDescriptionPageState();
}

class _MotelDescriptionPageState extends State<MotelDescriptionPage> {
  List<dynamic> images = [];
  GlobalKey globalKey;
  bool _isFv = false;
  @override
  void initState() {
    globalKey = GlobalKey();
    super.initState();
    for (var imgMotel in widget.motelModel.imageMotel) {
      images.add(CachedNetworkImage(
        imageUrl: imgMotel.imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(child: LoadingWidget()),
        errorWidget: (context, url, error) => Center(child: EmptyWidget()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            MotelDetailBloc()..add(FeatchDataEvent(widget.motelModel)),
        child: BlocListener<MotelDetailBloc, MotelDetailState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<MotelDetailBloc, MotelDetailState>(
                builder: (context, state) => _scaffold())));
  }

  void blocListener(MotelDetailState state, BuildContext context) {
    if (state is FeatchDataSucessState) {
      _isFv = state.isFv;
    }
  }

  Widget _scaffold() {
    return Scaffold(
      key: globalKey,
      body: Stack(
        children: <Widget>[
          buildPageView(),
          buildButtonBack(),
        ],
      ),
    );
  }

  Widget buildPageView() {
    return Positioned.fill(
      child: Container(
        color: AppColor.backgroundColor.withOpacity(0.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            sliderImg(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: Size.getHeight * 0.02,
                  left: Size.getWidth * 0.02,
                  right: Size.getWidth * 0.02,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildTitile(),
                      SizedBox(height: Size.getHeight * 0.01),
                      buildRating(),
                      SizedBox(height: Size.getHeight * 0.02),
                      buildTextAmentites(),
                      SizedBox(height: Size.getHeight * 0.01),
                      buildAmentitesList(),
                      SizedBox(height: Size.getHeight * 0.02),
                      buildTextDescription(),
                      SizedBox(height: Size.getHeight * 0.01),
                      Text(
                        widget.motelModel.description,
                        style: StyleText.subhead16Black,
                      ),
                      SizedBox(height: Size.getHeight * 0.02),
                      buildTextLocation(),
                      SizedBox(height: Size.getHeight * 0.01),
                      // Container(
                      //   height: Size.getHeight * 0.3,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(25),
                      //       color: Colors.white),
                      //   child: Placeholder(),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            buildBottomCallandBooking(),
          ],
        ),
      ),
    );
  }

  Container sliderImg() {
    return Container(
      height: Size.getHeight * 0.4,
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
  }

  Widget buildAmentitesList() {
    return Container(
      height: Size.getHeight * 0.12,
      width: Size.getWidth,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.motelModel.amenities.length,
        itemBuilder: (context, index) => _itemAmentites(index),
      ),
    );
  }

  Widget _itemAmentites(index) {
    return widget.motelModel.amenities[index].isHave
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
  }

  Widget buildTextAmentites() {
    return Text(
      "Amenities",
      style: StyleText.header20BlackW500,
    );
  }

  Widget buildTextLocation() {
    return Text(
      "Location",
      style: StyleText.header20BlackW500,
    );
  }

  Widget buildTextDescription() {
    return Text(
      "Description",
      style: StyleText.header20BlackW500,
    );
  }

  Widget buildRating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Rating:',
          textAlign: TextAlign.center,
          style: StyleText.subhead16Black500,
        ),
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
          '(${widget.motelModel.rating})',
          textAlign: TextAlign.center,
          style: StyleText.subhead16Black500,
        ),
      ],
    );
  }

  Widget buildTitile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 4.0),
              child: Text(
                widget.motelModel.title,
                style: StyleText.header24Black,
              ),
            ),
            Spacer(),
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
                  padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
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

  Widget buildBottomCallandBooking() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: AppColor.colorClipPath),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: Size.getHeight * 0.075,
            height: Size.getHeight * 0.075,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: AppColor.colorBlue156,
            ),
            child: Center(
              child: Icon(
                Icons.phone_iphone,
                size: 30.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Container(
            width: Size.getWidth * 0.65,
            height: Size.getHeight * 0.075,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), color: Colors.red),
            child: Center(
              child: Text(
                "Booking rent",
                style: StyleText.header20White,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildButtonBack() {
    return Positioned(
        top: 8,
        left: 8,
        child: SafeArea(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 40,
              height: 40,
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
          ),
        ));
  }
}

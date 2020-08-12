import 'package:cached_network_image/cached_network_image.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/helper/ulti.dart';
import 'package:findingmotels/models/history_model.dart';
import 'package:findingmotels/models/rate_model.dart';
import 'package:findingmotels/pages/history_detail/bloc/historydetail_bloc.dart';
import 'package:findingmotels/pages/widgets/dialog_custom/comment_dialog.dart';
// import 'package:findingmotels/pages/widgets/dialog_custom/comment_dialog.dart';
import 'package:findingmotels/pages/widgets/empty/empty_widget.dart';
import 'package:findingmotels/pages/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class HistoryDetailPage extends StatefulWidget {
  final HistoryModel historyModel;
  const HistoryDetailPage({this.historyModel});
  @override
  _HistoryDetailPageState createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  GlobalKey _globalKey;

  @override
  void initState() {
    _globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HistorydetailBloc(),
        child: BlocListener<HistorydetailBloc, HistorydetailState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<HistorydetailBloc, HistorydetailState>(
                builder: (context, state) => _scaffold(state))));
  }

  void blocListener(HistorydetailState state, BuildContext context) {}

  Widget _scaffold(HistorydetailState state) => Scaffold(
        key: _globalKey,
        backgroundColor: AppColor.backgroundColor,
        body: Stack(children: <Widget>[
          state is LoadingState ? LoadingWidget() : _body(state)
        ]),
      );
  Widget _body(HistorydetailState state) => Stack(
        children: <Widget>[_appBar(), _page()],
      );

  Widget _appBar() => Container(
        height: Size.getHeight * 0.35,
        width: Size.getWidth,
        child: Stack(
          children: <Widget>[
            _appBarImage(),
            _appBarbuttonBack()
          ],
        ),
      );

  Widget _appBarImage() {
    return Container(
      width: Size.getWidth,
      child: CachedNetworkImage(
        imageUrl: widget.historyModel.motelBooking.imageMotel[0].imageUrl,
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
      ),
    );
  }

  Widget _appBarbuttonBack() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 0,
      child: InkWell(
        onTap: () => print('onTap'),
        child: Container(
            width: 80.0,
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Colors.grey.withOpacity(0.5)),
            child: Center(
                child: Icon(Icons.arrow_back_ios,
                    size: 30.0, color: Colors.white))),
      ),
    );
  }

  Widget _page() => SingleChildScrollView(
        child: Container(
          height: Size.getHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _motelDetail(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _travelForWork(),
                      _guest(),
                      _timeInOut(),
                      _typeRoomPrice(),
                      Spacer(),
                      widget.historyModel.type == 0
                          ? _ratingButton()
                          : SizedBox(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget _ratingButton() {
    return GestureDetector(
      onTap: () async {
        int type = 0;
        double rating = 0.0;
        String txtComment = "";
        RateModel rateModel = await ConfigApp.fbCloudStorage
            .checkRatingHotels(widget.historyModel);
        if (rateModel != null) {
          type = 1;
          rating = rateModel.rating;
          if (rateModel.comment != "") {
            type = 3;
            txtComment = rateModel.comment;
          }
        }
        await commentDialog(
            context: context,
            historyModel: widget.historyModel,
            type: type,
            vrating: rating,
            txtComment: txtComment);
      },
      child: Container(
        height: 50.0,
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: AppColor.colorClipPath2),
        child: Center(
          child: Text(
            'Rating',
            style: StyleText.subhead18White500,
          ),
        ),
      ),
    );
  }

  Widget _typeRoomPrice() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 8, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 30.0,
              width: 30.0,
              child: SvgPicture.asset(AppSetting.typeRoomSvg)),
          SizedBox(width: 8.0),
          Text(
            '${Helper.getTypeRoom(widget.historyModel)}',
            style: StyleText.subhead18Black87w400,
          ),
          Spacer(),
          Text(
            '${widget.historyModel.detailBooking.totalPrice.toStringAsFixed(1)}',
            style: StyleText.subhead18Red87w400,
          ),
          Text(
            ' \$',
            style: StyleText.subhead18GreenMixBlue,
          ),
        ],
      ),
    );
  }

  Widget _timeInOut() {
    return Container(
      padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title('Time Check-In'),
              SizedBox(height: 8.0),
              _time(timeSelect: widget.historyModel.detailBooking.checkIn),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title('Time Check-Out'),
              SizedBox(height: 8.0),
              _time(timeSelect: widget.historyModel.detailBooking.checkOut),
            ],
          )
        ],
      ),
    );
  }

  Widget _guest() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 8, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 30.0,
              width: 30.0,
              child: SvgPicture.asset(AppSetting.guestIconSvg)),
          SizedBox(width: 8.0),
          Text(
            widget.historyModel.detailBooking.gustName == ""
                ? 'Main guest'
                : "Booking for ${widget.historyModel.detailBooking.gustName}",
            style: StyleText.subhead18Black87w400,
          )
        ],
      ),
    );
  }

  Widget _travelForWork() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 8, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 30.0,
              width: 30.0,
              child: SvgPicture.asset(
                  widget.historyModel.detailBooking.travelWork
                      ? AppSetting.workIconSvg
                      : AppSetting.relaxIconSvg)),
          SizedBox(width: 8.0),
          Text(
            widget.historyModel.detailBooking.travelWork
                ? 'Traveling for work'
                : "Traveling for Getaway",
            style: StyleText.subhead18Black87w400,
          )
        ],
      ),
    );
  }

  Widget _title(String title) =>
      Text(title, style: StyleText.subhead18GreenMixBlue);

  Widget _time({String timeSelect}) => Container(
        // margin: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 30.0,
                width: 30.0,
                child: SvgPicture.asset(AppSetting.eventIcon)),
            SizedBox(width: 8.0),
            Text(
              timeSelect,
              style: StyleText.subhead16Black500,
            )
          ],
        ),
      );

  Widget _motelDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: Size.getHeight * 0.22),
          height: Size.getHeight * 0.26,
          width: Size.getWidth * 0.8,
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ]),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Row(
                  children: <Widget>[
                    Container(
                      width: Size.getHeight * 0.12,
                      height: Size.getHeight * 0.12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: CachedNetworkImage(
                          imageUrl: widget
                              .historyModel.motelBooking.imageMotel[1].imageUrl,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              Center(child: SpinKitFadingCircle(
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                    color: index.isEven
                                        ? Colors.red
                                        : Colors.green),
                              );
                            },
                          )),
                          errorWidget: (context, url, error) =>
                              Center(child: EmptyWidget()),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            widget.historyModel.motelBooking.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleText.subhead16GreenMixBlue,
                          ),
                          SmoothStarRating(
                            rating: widget.historyModel.motelBooking.rating,
                            isReadOnly: true,
                            size: 16.0,
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star_half,
                            defaultIconData: Icons.star_border,
                            starCount: 5,
                            allowHalfRating: true,
                            spacing: 2.0,
                            onRated: (value) {},
                            color: Colors.amber,
                            borderColor: Colors.transparent,
                          ),
                          Text(
                            widget.historyModel.motelBooking.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleText.content14Grey400,
                          ),
                        ],
                      ),
                    )),
                  ],
                )),
                Container(height: 8.0),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    widget.historyModel.motelBooking.description,
                    maxLines: 4,
                    style: StyleText.content14Black400,
                  ),
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

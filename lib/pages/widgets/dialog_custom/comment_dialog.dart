import 'package:cached_network_image/cached_network_image.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/history_model.dart';
import 'package:findingmotels/pages/widgets/empty/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';

Future commentDialog({BuildContext context, HistoryModel historyModel}) {
  TextEditingController reviewEditingController = TextEditingController();
  int isRating = 0;
  double rating = 0.0;

  Widget _checkRating(
      HistoryModel historyModel, BuildContext context, StateSetter setState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 120.0,
          width: 120.0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0)),
            child: Container(
              height: 120.0,
              width: 120.0,
              child: CachedNetworkImage(
                  imageUrl: historyModel.motelBooking.imageMotel[1].imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: SpinKitFadingCircle(
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                              decoration: BoxDecoration(
                                  color: index.isEven
                                      ? Colors.red
                                      : Colors.green));
                        },
                      )),
                  errorWidget: (context, url, error) =>
                      Center(child: EmptyWidget())),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Center(
            child: Text(
              'Are you enjoy it?',
              style: StyleText.header20Black,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Center(
            child: Text(
              'Tap a start to rate ${historyModel.motelBooking.title}',
              style: StyleText.subhead16Black500,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 4, bottom: 4),
            height: 1.0,
            color: Colors.grey),
        Container(
          child: Center(
            child: FlutterRatingBar(
              itemSize: 50.0,
              fillColor: Colors.amber,
              borderColor: AppColor.colorClipPath2,
              initialRating: 0.0,
              onRatingUpdate: (v) {
                setState(() => rating = v);
              },
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 4), height: 1.0, color: Colors.grey),
        Container(
          height: 60.0,
          width: Size.getWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              color: Colors.white),
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, null);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: StyleText.subhead16GreenMixBlue
                            .copyWith(fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Container(width: 1.0, color: Colors.grey),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (rating != 0.0) {
                      setState(() {
                        isRating = 1;
                      });
                    } else if (rating < 3.0) {
                      showToast('Please tap start to select start Rate');
                    }
                    print(rating.toString());
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Center(
                      child: Text(
                        "Rating",
                        style: StyleText.subhead16GreenMixBlue
                            .copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _confirm(
      HistoryModel historyModel, BuildContext context, StateSetter setState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 120.0,
          width: 120.0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0),
              topLeft: Radius.circular(15.0),
            ),
            child: Container(
              height: 120.0,
              width: 120.0,
              child: CachedNetworkImage(
                  imageUrl: historyModel.motelBooking.imageMotel[1].imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: SpinKitFadingCircle(
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                              decoration: BoxDecoration(
                                  color: index.isEven
                                      ? Colors.red
                                      : Colors.green));
                        },
                      )),
                  errorWidget: (context, url, error) =>
                      Center(child: EmptyWidget())),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Center(
            child: Text(
              'Thanks for your feedback',
              style: StyleText.header20Black,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          child: Center(
            child: Text(
              'You can also write a review',
              style: StyleText.subhead16Black500,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ),
        Container(
          child: Center(
            child: FlutterRatingBar(
              itemSize: 30.0,
              fillColor: Colors.amber,
              borderColor: AppColor.colorClipPath2,
              initialRating: rating,
              onRatingUpdate: null,
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 4), height: 1.0, color: Colors.grey),
        Container(
          height: 50,
          width: Size.getWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              color: Colors.white),
          child: InkWell(
            onTap: () {
              setState(() => isRating = 2);
            },
            child: Container(
              // padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Center(
                child: Text(
                  "Write a Review",
                  style: StyleText.subhead18GreenMixBlue
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 4), height: 1.0, color: Colors.grey),
        Container(
          height: 50,
          width: Size.getWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              color: Colors.white),
          child: InkWell(
            onTap: () {
              Navigator.pop(context, null);
            },
            child: Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Center(
                child: Text(
                  "OK",
                  style: StyleText.subhead18GreenMixBlue
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
            child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          contentPadding: EdgeInsets.zero,
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: Size.getWidth,
              child: isRating == 0
                  ? _checkRating(historyModel, context, setState)
                  : isRating == 1
                      ? _confirm(historyModel, context, setState)
                      : _isReview(reviewEditingController, context),
              // : _isRating(reviewEditingController, context),
            );
          }),
        ));
      });
}

Widget _isReview(
    TextEditingController reviewEditingController, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _widgetAvatar(),
      _review(reviewEditingController),
      Container(
          margin: EdgeInsets.only(top: 16.0), height: 1.0, color: Colors.grey),
      GestureDetector(
        onTap: () {
          Navigator.pop(context, true);
        },
        child: Container(
          height: 50.0,
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
          ),
          child: Center(
            child: Text("Not now",
                style: StyleText.subhead18GreenMixBlue
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
        ),
      ),
      Container(height: 1.0, color: Colors.grey),
      GestureDetector(
        onTap: () {
          Navigator.pop(context, true);
        },
        child: Container(
          height: 50.0,
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
          ),
          child: Center(
            child: Text("Submit Review",
                style: StyleText.subhead18GreenMixBlue
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
        ),
      ),
    ],
  );
}

Widget _review(TextEditingController reviewEditingController) {
  return Container(
    padding: EdgeInsets.only(left: 4.0, right: 4.0),
    child: TextField(
        style: StyleText.subhead16Black,
        keyboardType: TextInputType.text,
        onTap: () {},
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.0),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColor.colorClipPath2, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColor.colorClipPath),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColor.colorClipPath2),
            ),
            hintText: "Write review...",
            hintStyle: StyleText.subhead16GreenMixBlue,
            alignLabelWithHint: true,
            labelStyle: StyleText.subhead16GreenMixBlue),
        maxLines: 6,
        controller: reviewEditingController),
  );
}

Widget _widgetAvatar() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            height: 24.0,
            width: 24.0,
            child: SvgPicture.asset(AppSetting.reviewIcon)),
        SizedBox(width: 4.0),
        Text('Write Review', style: StyleText.subhead18GreenMixBlue)
      ],
    ),
  );
}

Widget _avatar() {
  Widget _dataAvatar(ImageProvider imageProvider, String errorImg) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          image: DecorationImage(
              image: imageProvider != null
                  ? imageProvider
                  : NetworkImage(errorImg),
              fit: BoxFit.cover),
        ),
      );

  return Container(
    width: 24.0,
    height: 24.0,
    child: CachedNetworkImage(
        imageUrl: ConfigApp?.fbuser?.photoUrl ?? AppSetting.defaultAvatarImg,
        imageBuilder: (context, imageProvider) =>
            _dataAvatar(imageProvider, null),
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            _dataAvatar(null, AppSetting.defaultAvatarImg)),
  );
}

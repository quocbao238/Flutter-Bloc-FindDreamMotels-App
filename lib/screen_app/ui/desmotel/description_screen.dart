import 'package:findingmotels/screen_app/ui/desmotel/descripLocalData.dart';
import 'package:flutter/material.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MotelDescriptionPage extends StatefulWidget {
  final int index;
  MotelDescriptionPage({this.index});
  @override
  _MotelDescriptionPageState createState() => _MotelDescriptionPageState();
}

class _MotelDescriptionPageState extends State<MotelDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildBackground(),
          buildPageView(),
          buildButtonBack(),
        ],
      ),
    );
  }

  Widget buildPageView() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: Size.getHeight * 0.65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
          color: AppColor.backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: Size.getHeight * 0.04,
                  left: Size.getWidth * 0.06,
                  right: Size.getWidth * 0.06,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "Kos Tirto 2",
                                    style: StyleText.header24Black,
                                  ),
                                ),
                                SizedBox(height: Size.getHeight * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                    Text(
                                      "Ho Chi Minh , Vietnam",
                                      style: StyleText.subhead16Red500,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "750.000",
                                  maxLines: 1,
                                  style: StyleText.header24BlackW400,
                                ),
                                Text(
                                  "VND",
                                  maxLines: 1,
                                  style: StyleText.subhead16Red500,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: Size.getHeight * 0.01),
                      SmoothStarRating(
                        rating: 4.5,
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
                      SizedBox(height: Size.getHeight * 0.02),
                      Text(
                        "Amenities",
                        style: StyleText.header20BlackW500,
                      ),
                      SizedBox(height: Size.getHeight * 0.02),
                      Container(
                        height: Size.getHeight * 0.10,
                        width: Size.getWidth,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listAmenities.length,
                          itemBuilder: (context, index) => Container(
                            width: Size.getWidth * 0.20,
                            margin:
                                EdgeInsets.only(right: Size.getWidth * 0.025),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: Size.getWidth * 0.1,
                                  height: Size.getWidth * 0.1,
                                  child: Center(
                                    child: Image.asset(
                                        listAmenities[index].urlIcon),
                                  ),
                                ),
                                SizedBox(height: Size.getHeight * 0.01),
                                FittedBox(
                                  child: Text(
                                    listAmenities[index].name,
                                    textAlign: TextAlign.center,
                                    style: StyleText.subhead16Black500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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

  Container buildBottomCallandBooking() {
    return Container(
      height: Size.getHeight * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: Colors.white,
      ),
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
                borderRadius: BorderRadius.circular(15.0),
                color: AppColor.selectContainerColor),
            child: Center(
              child: Text(
                "Booking rent",
                style: StyleText.header20White,
              ),
            ),
          )
        ],
      ),
      // child: Placeholder(),
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

  Widget buildBackground() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: Size.getHeight * 0.4,
        child: Image.network(
          imageTest,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

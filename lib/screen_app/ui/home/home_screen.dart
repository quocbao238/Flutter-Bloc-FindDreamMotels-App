import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/screen_app/custom_widget/clip_path_custom/loginClipPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey loginGlobalKey;
  String imageUrl = 'assets/logoutSvg.svg';

  @override
  void initState() {
    loginGlobalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: loginGlobalKey,
          backgroundColor: AppColor.backgroundColor,
          body: Stack(
            children: <Widget>[
              buildBackground(Size.getHeight),
              Positioned.fill(
                  child: SafeArea(
                child: Column(
                  children: <Widget>[
                    buildTopView(),
                    Container(
                      margin: EdgeInsets.only(top: Size.getHeight * 0.0),
                      height: Size.getHeight * 0.0725,
                      child: Center(
                        child: Container(
                          width: Size.getWidth * 0.8,
                          padding: EdgeInsets.only(
                              left: 16.0, top: 4.0, bottom: 4.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(18.0),
                              color: Colors.white),
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  LineIcons.search,
                                  color: AppColor.colorBlue156,
                                  size: 24.0 * Size.scaleTxt,
                                ),
                                SizedBox(width: 12.0),
                                Text(
                                  "Search district",
                                  style: StyleText.subhead18Grey400,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTopView() {
    return Container(
      padding: EdgeInsets.only(left: 8.0),
      height: Size.getHeight * 0.3,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: Size.getWidth * 0.6,
                height: Size.getHeight * 0.28,
                child: SvgPicture.asset(imageUrl, fit: BoxFit.fill),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: Size.getHeight * 0.02),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.red[300],
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Ho Chi Minh, Viet Nam",
                      style: StyleText.content14White400,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Size.getHeight * 0.03, left: 8.0),
                child: Text(
                  "Hello, ${ConfigApp.fbuser.displayName}",
                  style: StyleText.content14White60w400,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Size.getHeight * 0.03, left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Find Your Dream",
                        style: GoogleFonts.vidaloka(
                            color: Colors.white, fontSize: 24 * Size.scaleTxt)),
                    SizedBox(height: Size.getHeight * 0.01),
                    Text("Boarding",
                        style: GoogleFonts.vidaloka(
                            color: Colors.white, fontSize: 24 * Size.scaleTxt)),
                    SizedBox(height: Size.getHeight * 0.01),
                    Text("Motel",
                        style: GoogleFonts.vidaloka(
                            color: Colors.white, fontSize: 24 * Size.scaleTxt)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBackground(double height) {
    return Positioned.fill(
      child: ClipPath(
        child: Container(
          color: AppColor.colorClipPath,
        ),
        clipper: HomeClipPath(),
      ),
    );
  }
}

import 'package:findingmotels/blocs/home_bloc/home_bloc.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/screen_app/custom_widget/clip_path_custom/loginClipPath.dart';
import 'package:findingmotels/screen_app/ui/desmotel/description_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey homeGlobalKey;
  String imageUrl = 'assets/logoutSvg.svg';
  String districSelect = "Quận 1";
  var rating = 3.0;

  List<String> districList = [
    "Quận 1",
    "Quận 2",
    "Quận 3",
    "Quận 4",
    "Quận 5",
    "Quận 6",
    "Quận 7",
    "Quận 8",
    "Quận 9",
    "Quận 10",
    "Quận 11",
    "Quận 12",
    "Quận Bình Tân",
    "Quận Bình Thạnh",
    "Quận Gò Vấp",
    "Quận Phú Nhuận",
    "Quận Tân Bình",
    "Quận Tân Phú",
    "Quận Thủ Đức",
    "Huyện Bình Chánh",
    "Huyện Cần Giờ",
    "Huyện Củ Chi",
    "Huyện Hóc Môn",
    "Huyện Nhà Bè"
  ];

  @override
  void initState() {
    homeGlobalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getSizeApp(context);
    return BlocProvider(
        create: (context) => HomeBloc(),
        child: BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is OnClickListDistrictsState) {
                districSelect = districList[state.index];
              } else if (state is OnClickListMotelssState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MotelDescriptionPage(
                              index: state.index,
                            )));
              }
            },
            child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) => buildBody(state))));
  }

  Widget buildBody(HomeState state) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: homeGlobalKey,
          backgroundColor: AppColor.backgroundColor,
          body: Stack(
            children: <Widget>[
              buildBackground(Size.getHeight),
              Positioned.fill(
                  child: SafeArea(
                child: Column(
                  children: <Widget>[
                    buildTopView(),
                    buildFindDistricts(),
                    buildListDistric(),
                    Spacer(),
                    buildViewMotels()
                  ],
                ),
              ))
            ],
          ),
        ),
      ],
    );
  }

  Widget buildViewMotels() {
    return Container(
      margin: EdgeInsets.only(bottom: Size.getHeight * 0.02),
      height: Size.getHeight * 0.35,
      padding: EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: districSelect.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) => InkWell(
              onTap: () {
                BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
                    .add(OnClickListMotelssEvent(index));
              },
              child: Container(
                margin: EdgeInsets.only(right: 16.0),
                padding: EdgeInsets.only(left: 12.0, bottom: 12.0),
                width: Size.getWidth * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSNbw9uLTPex9mX7-Z5A9GGiM2hS6GIxBlyS-Rxrf9Qu0Z_OuvW&usqp=CAU"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Nhà trọ giá rẻ ",
                      maxLines: 1,
                      style: StyleText.header20Whitew500,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Hẻm 60 - Cách Mạng Tháng Tám, phường 6, Quận 3, Hồ Chí Minh ",
                      maxLines: 1,
                      style: StyleText.content14White60w400,
                    ),
                    SizedBox(height: 8.0),
                    SmoothStarRating(
                      rating: rating,
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
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget buildListDistric() {
    return Container(
      margin: EdgeInsets.only(top: Size.getHeight * 0.04, left: 16.0),
      height: Size.getHeight * 0.06,
      width: Size.getWidth,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: districList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
                .add(OnClickListDistrictsEvent(index));
          },
          child: Container(
            margin: EdgeInsets.only(right: 12.0),
            width: Size.getWidth * 0.25,
            height: Size.getHeight * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: districSelect == districList[index]
                  ? Colors.red[300]
                  : Colors.white,
            ),
            child: Center(
              child: Text(
                districList[index],
                textAlign: TextAlign.center,
                style: districSelect == districList[index]
                    ? StyleText.subhead16White500
                    : StyleText.subhead16GreenMixBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFindDistricts() {
    return Container(
      margin: EdgeInsets.only(top: Size.getHeight * 0.00),
      height: Size.getHeight * 0.07,
      child: Center(
        child: Container(
          padding:
              EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0, right: 16.0),
          // color: Colors.red,
          child: TextFormField(
            style: StyleText.subhead18Grey400,
            cursorColor: AppColor.colorBlue156,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              hintText: 'Find districts',
              prefix: Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.only(right: 8.0),
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  LineIcons.search,
                  color: AppColor.colorBlue156,
                  size: 24.0 * Size.scaleTxt,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTopView() {
    return Container(
      padding: EdgeInsets.only(left: 8.0),
      height: Size.getHeight * 0.27,
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

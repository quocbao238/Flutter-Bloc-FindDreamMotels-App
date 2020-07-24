import 'package:carousel_slider/carousel_slider.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:findingmotels/pages/district/view/district_page.dart';
import 'package:findingmotels/pages/home/bloc/home_bloc.dart';
import 'package:findingmotels/pages/motel_detail/view/motel_detail_page.dart';
import 'package:findingmotels/pages/new_motel/view/new_motel_screen.dart';
import 'package:findingmotels/pages/widgets/home_item_motel.dart';
import 'package:findingmotels/widgets/clip_path_custom/loginClipPath.dart';
import 'package:findingmotels/widgets/empty/empty_widget.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey homeGlobalKey;
  String imageUrl = AppSetting.logoutImg;
  String districSelect = "District 1";
  CarouselController carouselController = CarouselController();
  var rating = 3.0;
  bool isHaveData = false;

  List<MotelModel> listMotels;

  @override
  void initState() {
    super.initState();
    listMotels = [];
    homeGlobalKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc()..add(FeatchDataEvent()),
        child: BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              blocListener(state, context);
            },
            child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) => buildBody(state))));
  }

  Future<void> blocListener(HomeState state, BuildContext context) async {
    if (state is FeatchDataSucesesState) {
      listMotels = state.listMotel;
      isHaveData = true;
    } else if (state is OnClickListDistrictsState) {
      districSelect = state.selectMotel.name;
      listMotels = state.listMotel;
    } else if (state is OnClickListMotelssState) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MotelDetailPage(motelModel: state.motelModel)));
    } else if (state is NewMotelState) {
      await Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewMotelPage()))
          .then((v) => BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
              .add(FeatchDataEvent()));
    } else if (state is OnTapHotelsState) {
      await Navigator.push(
              context, MaterialPageRoute(builder: (context) => DistrictPage()))
          .then((v) => BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
              .add(FeatchDataEvent()));
    }
  }

  Widget buildBody(HomeState state) {
    return Stack(
      children: <Widget>[
        Scaffold(
          resizeToAvoidBottomInset: false,
          key: homeGlobalKey,
          backgroundColor: AppColor.backgroundColor,
          body: _body(state),
          // floatingActionButton: FloatingActionButton(
          // onPressed: () {
          //   BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
          //       .add(NewMotelEvent());
          // },
          // backgroundColor: AppColor.colorClipPath.withOpacity(0.8),
          // child: Center(
          //   child: Icon(Icons.add),
          // )),
        ),
        state is LoadingState ? LoadingWidget() : SizedBox()
      ],
    );
  }

  Widget _body(HomeState state) {
    return Stack(
      children: <Widget>[
        buildBackground(Size.getHeight),
        Positioned.fill(
            child: SafeArea(
          child: Column(
            children: <Widget>[
              buildTopView(),
              _lookingFor(),
              Expanded(
                child: buildViewMotels(state),
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget buildViewMotels(HomeState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            children: <Widget>[
              Text('Popular Hotels',
                  style: GoogleFonts.heebo(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 18 * Size.scaleTxt)),
              Spacer(),
              Text('More',
                  style: GoogleFonts.heebo(
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline,
                      color: Colors.black87,
                      fontSize: 18 * Size.scaleTxt))
            ],
          ),
        ),
        listMotels.length > 0
            ? Expanded(
                child: CarouselSlider.builder(
                itemCount: listMotels.length,
                itemBuilder: (BuildContext context, int index) => HomeMotelItem(
                  motelModel: listMotels[index],
                  onTap: () {
                    BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
                        .add(OnClickListMotelssEvent(listMotels[index]));
                  },
                ),
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayCurve: Curves.easeInOut,
                  autoPlayInterval: Duration(milliseconds: 2000),
                ),
              ))
            : isHaveData ? Expanded(child: EmptyWidget()) : SizedBox()
      ],
    );
  }

  Widget _lookingFor() {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, left: 16.0, right: 8.0),
      // height: Size.getHeight * 0.08,
      width: Size.getWidth,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "What are you looking for?",
            style: GoogleFonts.heebo(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 24 * Size.scaleTxt),
          ),
          // SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              _itemLookingFor(
                  iconUrl: AppSetting.flightIcon,
                  title: "Fight",
                  onTap: () {
                    BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
                        .add(OnTapFightEvent());
                  }),
              _itemLookingFor(
                  iconUrl: AppSetting.hotelIcon,
                  title: "Hotels",
                  onTap: () {
                    BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
                        .add(OnTapHotelsEvent());
                  }),
              _itemLookingFor(
                  iconUrl: AppSetting.holidayIcon,
                  title: "Holidays",
                  onTap: () {
                    BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
                        .add(OnTapHolidaysEvent());
                  }),
              _itemLookingFor(
                  iconUrl: AppSetting.eventIcon,
                  title: "Event",
                  onTap: () {
                    BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
                        .add(OnTapEventEvent());
                  }),
            ],
          )
        ],
      ),
    );
  }

  Widget _itemLookingFor({String iconUrl, String title, Function onTap}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Container(
          height: 80,
          margin: EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColor.colorClipPath.withOpacity(0.1)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: SvgPicture.asset(iconUrl)),
                SizedBox(height: 8.0),
                Text(title,
                    style: GoogleFonts.heebo(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14 * Size.scaleTxt))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTopView() => Container(
        padding: EdgeInsets.only(left: 8.0),
        child: Stack(
          children: <Widget>[
            _topImage(),
            _topContent(),
          ],
        ),
      );

  Widget _topContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // color: Colors.red,
            margin: EdgeInsets.only(top: Size.statusBar),
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
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Hello, ${ConfigApp.fbuser.displayName}",
              style: StyleText.content14White60w400,
            ),
          ),
          Container(
            // margin: EdgeInsets.only(top: Size.getHeight * 0.03, left: 8.0),
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Find Your",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.vidaloka(
                        color: Colors.white, fontSize: 20 * Size.scaleTxt)),
                SizedBox(height: Size.getHeight * 0.01),
                Text("Your",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.vidaloka(
                        color: Colors.white, fontSize: 20 * Size.scaleTxt)),
                SizedBox(height: Size.getHeight * 0.01),
                Text("Dream Hotel",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.vidaloka(
                        color: Colors.white, fontSize: 20 * Size.scaleTxt)),
              ],
            ),
          )
        ],
      );

  Widget _topImage() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: Size.getWidth * 0.60,
            height: Size.getHeight * 0.3,
            child: SvgPicture.asset(imageUrl, fit: BoxFit.fill),
          ),
        ],
      );

  Widget buildBackground(double height) => Positioned.fill(
        child: ClipPath(
          child: Container(
            color: AppColor.colorClipPath,
          ),
          clipper: HomeClipPath(0.32),
        ),
      );
}

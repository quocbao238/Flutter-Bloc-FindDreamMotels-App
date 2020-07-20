import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/models/district_model.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:findingmotels/pages/home/bloc/home_bloc.dart';
import 'package:findingmotels/pages/motel_detail/motels_description_screen.dart';
import 'package:findingmotels/pages/new_motel/view/new_motel_screen.dart';
import 'package:findingmotels/pages/widgets/home_item_motel.dart';
import 'package:findingmotels/widgets/clip_path_custom/loginClipPath.dart';
import 'package:findingmotels/widgets/empty/empty_widget.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey homeGlobalKey;
  String imageUrl = AppSetting.logoutImg;
  String districSelect = "District 1";
  var rating = 3.0;

  List<DistrictModel> listDistrict = [];
  List<MotelModel> listMotels = [];

  @override
  void initState() {
    super.initState();
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
      listDistrict = state.listDistrict;
      listMotels = state.listMotel;
    } else if (state is OnClickListDistrictsState) {
      districSelect = state.selectMotel.name;
      listMotels = state.listMotel;
    } else if (state is OnClickListMotelssState) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MotelDescriptionPage(
                    motelModel: state.motelModel
                  )));
    } else if (state is NewMotelState) {
      await Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewMotelPage()))
          .then((v) => BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
              .add(FeatchDataEvent()));
    }
  }

  Widget buildBody(HomeState state) {
    return Stack(
      children: <Widget>[
        Scaffold(
          resizeToAvoidBottomInset: true,
          key: homeGlobalKey,
          backgroundColor: AppColor.backgroundColor,
          body: _body(state),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
                    .add(NewMotelEvent());
              },
              backgroundColor: AppColor.colorClipPath.withOpacity(0.8),
              child: Center(
                child: Icon(Icons.add),
              )),
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
              // buildFindDistricts(),
              buildListDistric(),
              // Spacer(),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    buildViewMotels(),
                    state is LoadingMotels
                        ? Center(
                            child: SpinKitThreeBounce(
                              size: 50.0,
                            
                              duration: Duration(milliseconds: 1000),
                              color: AppColor.colorClipPath,
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget buildViewMotels() {
    return listMotels.length > 0
        ? Container(
            margin: EdgeInsets.only(bottom: Size.getHeight * 0.02),
            // height: Size.getHeight * 0.35,
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: listMotels.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) => HomeMotelItem(
                    motelModel: listMotels[index],
                    onTap: () {
                      BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
                          .add(OnClickListMotelssEvent(listMotels[index]));
                    },
                  )),
            ),
          )
        : EmptyWidget();
  }

  Widget buildListDistric() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16, left: 8.0,right: 32.0),
      height: Size.getHeight * 0.06,
      width: Size.getWidth,
      color: Colors.red,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listDistrict.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            if (!ConfigApp.drawerShow) {
              BlocProvider.of<HomeBloc>(homeGlobalKey.currentContext)
                  .add(OnClickListDistrictsEvent(listDistrict[index]));
            }
          },
          child: Container(
            margin: EdgeInsets.only(right: 12.0),
            width: Size.getWidth * 0.25,
            height: Size.getHeight * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: districSelect == listDistrict[index].name
                  ? Colors.red[300]
                  : Colors.white,
            ),
            child: Center(
              child: Text(
                listDistrict[index].name,
                textAlign: TextAlign.center,
                style: districSelect == listDistrict[index].name
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
      height: 40.0,
      margin: EdgeInsets.only(top: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      // child: Placeholder(),
      child: TextFormField(
        style: StyleText.subhead18GreenMixBlue,
        cursorColor: AppColor.colorBlue156,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8.0),
          filled: true,
          enabled: false,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          prefixIcon: Icon(
            Icons.home,
            color: AppColor.colorBlue156,
          ),
          hintText: 'Search Districts',
          suffixIcon: InkWell(
            onTap: () {
              showToast("Search");
            },
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.search,
                size: 24,
              ),
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
                Text("Find Your Dream",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.vidaloka(
                        color: Colors.white, fontSize: 20 * Size.scaleTxt)),
                SizedBox(height: Size.getHeight * 0.01),
                Text("Boarding",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.vidaloka(
                        color: Colors.white, fontSize: 20 * Size.scaleTxt)),
                SizedBox(height: Size.getHeight * 0.01),
                Text("Motel HCM",
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

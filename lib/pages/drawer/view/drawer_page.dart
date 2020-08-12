import 'package:cached_network_image/cached_network_image.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/dashboard/dashboard_page.dart';
import 'package:findingmotels/pages/drawer/bloc/drawer_bloc.dart';
import 'package:findingmotels/pages/drawer/view/mydrawer.dart';
import 'package:findingmotels/pages/new_motel/view/new_motel_screen.dart';
import 'package:findingmotels/pages/user_edit/view/user_edit_page.dart';
import 'package:findingmotels/pages/widgets/dialog_custom/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oktoast/oktoast.dart';
import '../../../main.dart';
import 'package:flutter_icons/flutter_icons.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class DrawerDashBoard extends StatefulWidget {
  @override
  _DrawerDashBoardState createState() => _DrawerDashBoardState();
}

class _DrawerDashBoardState extends State<DrawerDashBoard>
    with SingleTickerProviderStateMixin {
  GlobalKey _globalKey;
  AnimationController _controller;
  Animation<double> _scaleAnimation, _scaleAnimation2, _scaleAnimation3;

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _scaleAnimation = Tween<double>(begin: 1, end: 0.7).animate(_controller);
    _scaleAnimation2 = Tween<double>(begin: 1, end: 0.725).animate(_controller);
    _scaleAnimation3 = Tween<double>(begin: 1, end: 0.75).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getSizeApp(context);
    return BlocProvider(
        create: (context) => DrawerBloc(),
        child: BlocListener<DrawerBloc, DrawerState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<DrawerBloc, DrawerState>(
                builder: (context, state) => _scaffold())));
  }

  void blocListener(DrawerState state, BuildContext context) {
    if (state is MenuCloseState) {
      _controller.reverse();
      ConfigApp.drawerShow = false;
    } else if (state is MeunuOpenState) {
      _controller.forward();
      ConfigApp.drawerShow = true;
    }
  }

  Widget _scaffold() {
    return Scaffold(
      key: _globalKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: <Widget>[
          _menuBar(),
          _dashboard(
              scaleAnimation: _scaleAnimation3,
              screenWidth: Size.getWidth / 1.04,
              color: AppColor.backgroundColor),
          _dashboard(
              scaleAnimation: _scaleAnimation2,
              screenWidth: Size.getWidth / 1.02,
              color: AppColor.whiteColor),
          _dashboard(
              scaleAnimation: _scaleAnimation,
              screenWidth: Size.getWidth,
              color: null),
        ],
      ),
    );
  }

  Widget _menuBar() => InkWell(
        onTap: () {
          BlocProvider.of<DrawerBloc>(_globalKey.currentContext)
              .add(MenuEvent(false));
        },
        child: Container(
          width: Size.getWidth,
          height: Size.getHeight,
          color: AppColor.colorClipPath,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _avatar(),
                _titleName(
                    text: ConfigApp.fbuser.displayName ?? "",
                    textStyle: StyleText.header20White),
                _titleName(
                    text: ConfigApp.fbuser.email ?? "",
                    textStyle: StyleText.content14White400),
                _signout(),
                SizedBox(height: 10.0),
                _item(
                    icon: AntDesign.plus,
                    title: 'New Post',
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewMotelPage()))),
                _item(
                    icon: AntDesign.user,
                    title: 'User Profile',
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserEditPage()))),
                // _item(icon: Icons.chat, title: 'Chat', onTap: () {}),
                Spacer(),
                _rateApp(),
                _communicate(),
                _item(icon: Icons.lock, title: 'Privacy Policy', onTap: () => showToast('Contact Us')),
                _item(
                    icon: Icons.call,
                    title: 'Contact Us',
                    onTap: () => showToast('Contact Us')),
                _item(
                    icon: Icons.error,
                    title: 'Version ${AppSetting.version}',
                    onTap: () {}),
              ],
            ),
          ),
        ),
      );

  Widget _signout() {
    return InkWell(
      onTap: () async {
        await logoutDialog(
          context: _globalKey.currentContext,
          title: "Are you sure you want to Sign Out?",
          avgImage: AppSetting.logoutImg,
        ).then((v) {
          try {
            if (v) {
              ConfigApp.firebaseAuth.signOut().then((_) {
                ConfigApp.drawerShow = false;
                Navigator.of(_globalKey.currentContext)
                    .pushReplacement(new MaterialPageRoute(builder: (context) {
                  return App();
                }));
              });
            }
          } catch (e) {
            // showToast(e.toString());
          }
        });
      },
      child: Container(
        width: Size.getWidth * 0.42,
        margin: EdgeInsets.only(left: 8.0, top: 10.0),
        // padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
        child: Container(
          height: Size.getHeight * 0.05,
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              'Sign out'.toUpperCase(),
              style: StyleText.subhead16White500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _communicate() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 1,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Communicate',
              style: StyleText.subhead16White500,
            ),
          )
        ],
      );

  Widget _rateApp() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 1,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Rate App',
                  style: StyleText.subhead16White500,
                ),
                SizedBox(width: 8.0),
                Container(
                  width: Size.getWidth * 0.3,
                  child: FittedBox(
                    child: FlutterRatingBar(
                      initialRating: 3.5,
                      itemSize: 30.0,
                      fillColor: Colors.amber,
                      borderColor: Colors.amber.withAlpha(60),
                      allowHalfRating: true,
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 8.0),
          //   child: FittedBox(
          //     child: Container(
          //       child: FlutterRatingBar(
          //         initialRating: 3.5,
          //         itemSize: 30.0,
          //         fillColor: Colors.amber,
          //         borderColor: Colors.amber.withAlpha(60),
          //         allowHalfRating: true,
          //         onRatingUpdate: (rating) {
          //           print(rating);
          //         },
          //       ),
          //     ),
          //   ),
          // ),
        ],
      );

  Widget _titleName({String text, TextStyle textStyle}) => Container(
        margin: EdgeInsets.only(top: 8.0, left: 8.0),
        width: Size.getWidth * 0.42,
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      );

  Widget _item({String title, IconData icon, Function onTap}) => InkWell(
        onTap: () {
          if (onTap != null) {
            // BlocProvider.of<DrawerBloc>(_globalKey.currentContext)
            //     .add(MenuEvent(false));
            onTap();
          }
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          width: Size.getWidth * 0.5,
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(icon, color: Colors.white, size: 30.0),
                  SizedBox(width: 20.0),
                  Text(title, style: StyleText.subhead16White500)
                ],
              ),
            ],
          ),
        ),
      );

  Widget _dashboard(
      {Animation<double> scaleAnimation, double screenWidth, Color color}) {
    return MyDrawer(
      duration: Duration(milliseconds: 200),
      onMenuTap: () {
        BlocProvider.of<DrawerBloc>(_globalKey.currentContext)
            .add(MenuEvent(true));
      },
      scaleAnimation: scaleAnimation,
      isCollapsed: !ConfigApp.drawerShow,
      screenWidth: screenWidth,
      child: color == null
          ? InkWell(
              onTap: () {
                BlocProvider.of<DrawerBloc>(_globalKey.currentContext)
                    .add(MenuEvent(false));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(ConfigApp.drawerShow ? 30.0 : 0.0),
                ),
                child: DashboardPage(
                  onUserTap: () {
                    BlocProvider.of<DrawerBloc>(_globalKey.currentContext)
                        .add(MenuEvent(true));
                  },
                ),
              ),
            )
          : Material(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
              color: color),
    );
  }

  Widget _avatar() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 8.0, top: 8.0),
        width: Size.getWidth * 0.42,
        height: Size.getWidth / 3.2,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: ConfigApp?.fbuser?.photoUrl ??
                "https://huyhoanhotel.com/wp-content/uploads/2016/05/765-default-avatar-320x320.png",
            imageBuilder: (context, imageProvider) =>
                _dataAvatar(imageProvider, null),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                _dataAvatar(null, AppSetting.defaultAvatarImg),
          ),
        ),
      ),
    );
  }

  Widget _dataAvatar(ImageProvider imageProvider, String errorImg) => Container(
        width: Size.getWidth / 3.2,
        height: Size.getWidth / 3.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          image: DecorationImage(
              image: imageProvider != null
                  ? imageProvider
                  : NetworkImage(errorImg),
              fit: BoxFit.cover),
        ),
        // child: Stack(
        //   children: <Widget>[
        //     Positioned(
        //       bottom: 0,
        //       right: 0,
        //       child: Container(
        //         padding: EdgeInsets.only(bottom: 2.0),
        //         height: 30,
        //         width: 30,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(30.0),
        //             color: Colors.grey[400],
        //             border: Border.all(color: Colors.white, width: 1.0)),
        //         child: Center(
        //           child: Icon(
        //             Icons.camera_enhance,
        //             color: Colors.black87,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      );
}

import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/main.dart';
import 'package:findingmotels/repository/user_repository.dart';
import 'package:findingmotels/screen_app/ui/dashboard/show_Alert_custome.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:oktoast/oktoast.dart';

class DashboardPage extends StatefulWidget {
  final UserRepository userRepository;
  DashboardPage({@required this.userRepository});
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GlobalKey homeGlobalKey = GlobalKey();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Likes',
      style: optionStyle,
    ),
    Text(
      'Index 2: Search',
      style: optionStyle,
    ),
    Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    getSizeApp(context);
    return pageView(context, Size.getWidth, Size.getHeight);
  }

  WillPopScope pageView(
      BuildContext context, double getHeight, double getWidth) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: homeGlobalKey,
        backgroundColor: AppColor.backgroundColor,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 20,
                  color: AppColor.colorBlue156.withOpacity(0.3)),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  gap: 8,
                  activeColor: AppColor.whiteColor,
                  color: AppColor.colorBlue156,
                  tabBackgroundColor: AppColor.selectContainerColor,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  duration: Duration(milliseconds: 800),
                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: LineIcons.search,
                      text: 'Search',
                    ),
                    GButton(
                      icon: LineIcons.heart_o,
                      text: 'Likes',
                    ),
                    GButton(
                      icon: LineIcons.bell,
                      text: 'Notify',
                    ),
                    GButton(
                      icon: LineIcons.user,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      if (index != 4) {
                        _selectedIndex = index;
                      } else {
                        _onMenuPressed(
                            context: homeGlobalKey.currentContext,
                            getHeight: getHeight);
                      }
                    });
                  }),
            ),
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }

  Widget buildTopView(double getWidth, double getHeight) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: getWidth * 0.05),
          height: getHeight * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              GestureDetector(
                onTap: () {
                  _onMenuPressed(
                      context: homeGlobalKey.currentContext,
                      getHeight: getHeight);
                  // customDialog(
                  //     context: homeGlobalKey.currentContext,
                  //     title: "Are you sure you want to Loggout?",
                  //     avgImage: "assets/logoutSvg.svg",
                  //     function: (v) {
                  //       if (v) {
                  //         showToast("Logout");
                  //         widget.userRepository.signOut().then((v) =>
                  //             Navigator.of(homeGlobalKey.currentContext)
                  //                 .pushReplacement(
                  //                     new MaterialPageRoute(builder: (context) {
                  //               return App();
                  //             })));
                  //       }
                  //     });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  child: ClipOval(
                    child: Image.network(
                      ConfigApp.fbuser.photoUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void _onMenuPressed({BuildContext context, double getHeight}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Color(0xFF737373),
        height: getHeight * 0.4,
        child: Container(
          child: _buildMenuWidgetBotom(context),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildMenuWidgetBotom(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Center(
            child: ListTile(
              title: Text(
                'Help and Support',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    title: new Text('Notification'),
                    content: new Text('The feature are improving'),
                  ),
                );
              },
            ),
          ),
        ),
        Divider(height: 2.0, color: Colors.black),
        Expanded(
          flex: 4,
          child: Center(
            child: ListTile(
              title: Text(
                'Privacy Settings',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    title: new Text('Notification'),
                    content: new Text('The feature are improving'),
                  ),
                );
              },
            ),
          ),
        ),
        Divider(height: 2.0, color: Colors.black),
        Expanded(
          flex: 4,
          child: Center(
            child: ListTile(
              title: Text(
                'Log out',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              ),
              onTap: () async {
                Navigator.pop(context);
                await customDialog(
                  context: homeGlobalKey.currentContext,
                  title: "Are you sure you want to Loggout?",
                  avgImage: "assets/logoutSvg.svg",
                ).then((v) {
                  try {
                    if (v) {
                      // showToast("Logout");
                      ConfigApp.userRepository.signOut().then((v) =>
                          Navigator.of(homeGlobalKey.currentContext)
                              .pushReplacement(
                                  new MaterialPageRoute(builder: (context) {
                            return App();
                          })));
                    }
                  } catch (e) {
                    showToast(e.toString());
                  }
                });
              },
            ),
          ),
        ),
        Divider(height: 2.0, color: Colors.black),
      ],
    );
  }
}

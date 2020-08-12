import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/favorite/view/favorite_page.dart';
import 'package:findingmotels/pages/home/view/home_page.dart';
import 'package:findingmotels/pages/notifycation/view/notify_screen.dart';
import 'package:findingmotels/pages/search/view/search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class DashboardPage extends StatefulWidget {
  final Function onUserTap;
  DashboardPage({@required this.onUserTap});
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  GlobalKey dashboardGlobalKey = GlobalKey();
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    FavoritePage(),
    NotifyPage(),
  ];

  @override
  void initState() {
    super.initState();
    ConfigApp.oneSignalService.notificationReceivedHandler((oSNotification) {
      print(oSNotification.jsonRepresentation());
    });
    ConfigApp.oneSignalService.notificationOpenedHandler((result) {
      print(result.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return _pageView(context, Size.getWidth, Size.getHeight);
  }

  Widget _pageView(BuildContext context, double getHeight, double getWidth) =>
      Scaffold(
        backgroundColor: AppColor.backgroundColor,
        key: dashboardGlobalKey,
        bottomNavigationBar: _bottomNavigationBar(),
        body: _widgetOptions.elementAt(_selectedIndex),
      );

  Widget _bottomNavigationBar() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: FittedBox(
              child: GNav(
                  gap: 12,
                  activeColor: AppColor.whiteColor,
                  color: AppColor.blackColor,
                  tabBackgroundColor: AppColor.colorClipPath,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  duration: Duration(milliseconds: 200),
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
                      text: 'Favorite',
                    ),
                    GButton(
                      icon: LineIcons.history,
                      text: 'History'
                    ),
                    GButton(
                      icon: LineIcons.user,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    if (!ConfigApp.drawerShow) {
                      setState(() {
                        if (index != 4) {
                          _selectedIndex = index;
                        } else {
                          if (widget.onUserTap != null) {
                            widget.onUserTap();
                          }
                        }
                      });
                    }
                  }),
            ),
          ),
        ),
      );
}

import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/screen_app/custom_widget/clip_path_custom/loginClipPath.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey loginGlobalKey;

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
            ],
          ),
        ),
      ],
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

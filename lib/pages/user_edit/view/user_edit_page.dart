import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/sizeScreen.dart' as app;
import 'package:findingmotels/pages/tutorial/bloc/tutorial_bloc.dart';
import 'package:findingmotels/widgets/customcatch_image/customcatch_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserEditPage extends StatefulWidget {
  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  GlobalKey globalKey;
  TextEditingController _controller =
      TextEditingController(text: "Demo demo demo");

  @override
  void initState() {
    globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserEditlBloc(),
        child: BlocListener<UserEditlBloc, UserEditlState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<UserEditlBloc, UserEditlState>(
                builder: (context, state) => _scaffold())));
  }

  void blocListener(UserEditlState state, BuildContext context) {}

  Widget _scaffold() => Scaffold(
        key: globalKey,
        appBar: _appBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  child: Column(
                    children: <Widget>[
                      _item(
                          title: 'First Name',
                          controller: _controller,
                          isEdit: false),
                      _item(
                          title: 'Last Name',
                          controller: _controller,
                          isEdit: false),
                      _item(
                          title: 'BirthDay',
                          controller: _controller,
                          isEdit: false),
                      _item(
                          title: 'Email',
                          controller: _controller,
                          isEdit: false),
                      _item(
                          title: 'Location',
                          controller: _controller,
                          isEdit: true),
                      Expanded(
                        child: Container(
                          color: Colors.red
                        ),
                      ),
                      SizedBox(height: 16.0)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: app.AppColor.backgroundColor,
      );

  InkWell _item(
          {String title, TextEditingController controller, bool isEdit}) =>
      InkWell(
        onTap: () {},
        child: Container(
          height: 60.0,
          padding: EdgeInsets.all(10.0),
          child: TextField(
            maxLines: 1,
            enabled: isEdit,
            controller: controller,
            style: app.StyleText.subhead18Black87w400,
            decoration: InputDecoration(
                prefix: Container(
                  width: app.Size.getWidth * 0.3,
                  padding: EdgeInsets.only(left: 5, right: 15.0),
                  child: Text(
                    title.toUpperCase(),
                    style: app.StyleText.subhead16GreenMixBlue,
                    maxLines: 1,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0)),
          ),
        ),
      );

  Widget _appBar() => PreferredSize(
        preferredSize: Size.fromHeight(app.Size.getHeight * 0.4),
        child: AppBar(
          backgroundColor: app.AppColor.colorClipPath,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Edit Profile',
            style: app.StyleText.header24BWhite,
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(
                  Icons.check_circle_outline,
                  size: 30.0,
                ),
                onPressed: () {},
              ),
            ),
          ],
          flexibleSpace: _flexibleSpace(),
        ),
      );

  Widget _flexibleSpace() => Container(
        margin: EdgeInsets.only(
            top:
                MediaQuery.of(context).padding.top + app.Size.getHeight * 0.06),
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _avatar(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                ConfigApp.fbuser.displayName ?? "",
                style: app.StyleText.header24BWhitew400,
              ),
            ),
            Container(
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _itemBtn(
                      title: "My Account", color: app.AppColor.alerBtnColor),
                  _itemBtn(
                      title: "My Resume",
                      color: app.AppColor.selectContainerColor)
                ],
              ),
            )
          ],
        ),
      );

  Widget _itemBtn({String title, Color color, Function onTap}) => InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Container(
          width: app.Size.getWidth * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0), color: color),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: app.StyleText.subhead18White500,
            ),
          ),
        ),
      );

  Widget _avatar() => Container(
        height: app.Size.getHeight * 0.15,
        width: app.Size.getHeight * 0.15,
        child: Stack(
          children: <Widget>[
            Container(
              height: app.Size.getHeight * 0.15,
              width: app.Size.getHeight * 0.15,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[400]),
            ),
            Container(
              padding: EdgeInsets.all(4.0),
              width: app.Size.getHeight * 0.15,
              height: app.Size.getHeight * 0.15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90.0),
                child: ImageCacheNetwork(
                  url: ConfigApp?.fbuser?.photoUrl ?? "",
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.only(bottom: 2.0),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.grey[400],
                    border: Border.all(color: Colors.white, width: 1.0)),
                child: Center(
                  child: Icon(
                    Icons.camera_enhance,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

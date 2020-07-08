import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/sizeScreen.dart' as app;
import 'package:findingmotels/pages/user_edit/bloc/user_edit_bloc.dart';
import 'package:findingmotels/widgets/clip_path_custom/loginClipPath.dart';
import 'package:findingmotels/widgets/customcatch_image/customcatch_image.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
        create: (context) => UserEditBloc(),
        child: BlocListener<UserEditBloc, UserEditState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<UserEditBloc, UserEditState>(
                builder: (context, state) => _scaffold(state))));
  }

  void blocListener(UserEditState state, BuildContext context) {}

  Widget _scaffold(UserEditState state) => Scaffold(
      key: globalKey,
      body: _body(state),
      backgroundColor: app.AppColor.backgroundColor);

  Widget _body(UserEditState state) => Stack(
        children: <Widget>[
          buildBackground(0.32),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[_appBar(), content()],
          ),
          state is LoadingState ? LoadingWidget() : const SizedBox(),
        ],
      );

  Widget content() => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16.0),
              _item(title: 'First Name', controller: _controller, isEdit: true),
              _item(title: 'Last Name', controller: _controller, isEdit: true),
              _item(title: 'BirthDay', controller: _controller, isEdit: true),
              _item(title: 'Email', controller: _controller, isEdit: true),
              _item(title: 'Location', controller: _controller, isEdit: true),
              SizedBox(height: 8.0)
            ],
          ),
        ),
      );

  Widget _appBar() => Container(
        padding: EdgeInsets.only(top: 32.0),
        margin: EdgeInsets.only(bottom: app.Size.getHeight * 0.02),
        child: Column(
          children: <Widget>[
            _appbarTitle(),
            _avatar(),
            _userName(),
          ],
        ),
      );

  Widget _appbarTitle() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _leadIcon(),
          Text('Edit User',
              textAlign: TextAlign.center,
              style: GoogleFonts.vidaloka(
                  color: Colors.white, fontSize: 24 * app.Size.scaleTxt)),
          _rightIcon(),
        ],
      );

  Widget _userName() => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          ConfigApp.fbuser.displayName ?? "",
          style: app.StyleText.header24BWhitew400,
        ),
      );

  Widget _rightIcon() => IconButton(
        icon: Icon(Icons.check_circle_outline, size: 30.0, color: Colors.white),
        onPressed: () {},
      );

  Widget _leadIcon() => IconButton(
        icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.white),
        onPressed: () {
          Navigator.pop(globalKey.currentContext);
          FocusScope.of(context).requestFocus(FocusNode());
        },
      );

  Widget buildBackground(double height) => Positioned.fill(
        child: ClipPath(
          child: Container(
            color: app.AppColor.colorClipPath,
          ),
          clipper: HomeClipPath(height),
        ),
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

  Widget _avatar() => GestureDetector(
        onTap: () {
          print('Demo');
          BlocProvider.of<UserEditBloc>(globalKey.currentContext)
              .add(UpdateAvatarEvent());
        },
        child: Container(
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
                bottom: 4,
                right: 0,
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
        ),
      );
}

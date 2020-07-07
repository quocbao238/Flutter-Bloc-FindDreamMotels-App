import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/tutorial/bloc/tutorial_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserEditPage extends StatefulWidget {
  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  GlobalKey globalKey;

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
        body: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        backgroundColor: AppColor.backgroundColor,
      );

  Widget _appBar() => AppBar(
        backgroundColor: AppColor.colorClipPath,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit Profile',
          style: StyleText.header20White,
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
      );
}

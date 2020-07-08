
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/notifycation/bloc/notify_bloc.dart';
import 'package:findingmotels/pages/widgets/notify_item.dart';
import 'package:findingmotels/widgets/clip_path_custom/loginClipPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifyPage extends StatefulWidget {
  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  GlobalKey globalKey;

  @override
  void initState() {
    globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NotifyBloc(),
        child: BlocListener<NotifyBloc, NotifyState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<NotifyBloc, NotifyState>(
                builder: (context, state) => _scaffold())));
  }

  void blocListener(NotifyState state, BuildContext context) {}

  Widget _scaffold() => Scaffold(
        key: globalKey,
        backgroundColor: AppColor.backgroundColor,
        body: Stack(children: <Widget>[buildBackground(0.13), _body()]),
      );

  Widget _body() => Positioned.fill(
        child: Column(
          children: <Widget>[
            _appBar(),
            _content(),
          ],
        ),
      );

  Widget _content() => Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) => NotifyItem(
                  index: index,
                  isMessage: index % 2 == 0,
                  onTap: () {},
                )),
      );
}

Widget _appBar() => Container(
      padding: EdgeInsets.only(top: 32.0),
      margin: EdgeInsets.only(bottom: Size.getHeight * 0.02),
      child: Text('Notification',
          textAlign: TextAlign.center,
          style: GoogleFonts.vidaloka(
              color: Colors.white, fontSize: 24 * Size.scaleTxt)),
    );

Widget buildBackground(double height) => Positioned.fill(
      child: ClipPath(
        child: Container(
          color: AppColor.colorClipPath,
        ),
        clipper: HomeClipPath(height),
      ),
    );

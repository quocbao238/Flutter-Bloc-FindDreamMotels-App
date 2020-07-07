import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/notifycation/bloc/notify_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
        appBar: _appBar(),
        body: ListView.builder(
            shrinkWrap: false,
            itemCount: 5,
            itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 48.0,
                        width: 48.0,
                        child: SvgPicture.asset(index % 2 == 0
                            ? AppSetting.messageIconSvg
                            : AppSetting.favoriteIconSvg),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: Text(
                          'You have Message',
                          style: StyleText.subhead16GreenMixBlue,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        height: 48.0,
                        width: 48.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.colorClipPath.withOpacity(0.2),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
      );

  Widget _appBar() => AppBar(
        backgroundColor: AppColor.colorClipPath,
        title: Text(
          'Notification',
          style: StyleText.header20Whitew500,
        ),
      );
}

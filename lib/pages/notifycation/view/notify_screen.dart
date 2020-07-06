import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/notifycation/bloc/notify_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.notifications_active,
                          size: 30.0, color: AppColor.colorClipPath),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Conan',
                                style: StyleText.header20BlackW500,
                              ),
                              Icon(Icons.timelapse),
                              Text('19:45 PM')
                            ],
                          )
                        ],
                      )
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

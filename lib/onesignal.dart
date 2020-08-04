import 'package:findingmotels/config_app/configApp.dart';
import 'package:flutter/material.dart';

class OneSignalPage extends StatefulWidget {
  @override
  _OneSignalPageState createState() => _OneSignalPageState();
}

class _OneSignalPageState extends State<OneSignalPage> {
  String dataNotify = '';
  @override
  void initState() {
    super.initState();
    ConfigApp.oneSignalService.oneSignalInit();
    ConfigApp.oneSignalService.oneSingalListen();
    ConfigApp.oneSignalService.notificationReceivedHandler((oSNotification) {
      setState(() {
        print(oSNotification.jsonRepresentation());
        dataNotify = oSNotification.jsonRepresentation();
      });
    });
    ConfigApp.oneSignalService.notificationOpenedHandler((result) {
      setState(() {
        print(result.toString());
        dataNotify = 'notificationOpenedHandler';
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('One Signal'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(dataNotify),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ConfigApp.oneSignalService.sendNotifyToManagerHotel(null);
        },
      ),
    );
  }
}

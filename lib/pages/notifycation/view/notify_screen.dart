import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:flutter/material.dart';

class NotifyPage extends StatefulWidget {
  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Notify Page",
        style: StyleText.header20Black,
      ),
    );
  }
}

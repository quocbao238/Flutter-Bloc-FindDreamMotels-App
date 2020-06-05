import 'package:findingmotels/screen_app/ui/logout/logout_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Find Accommodation',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: LogOutPage(),
  ));
}

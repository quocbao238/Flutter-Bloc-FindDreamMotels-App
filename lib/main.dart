import 'package:findingmotels/Screen/login/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Find Accommodation',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: LoginPage(),
  ));
}
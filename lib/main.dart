import 'package:flutter/material.dart';

import 'Screen/ui/logout/logout_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Find Accommodation',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: LogOutPage(),
  ));
}

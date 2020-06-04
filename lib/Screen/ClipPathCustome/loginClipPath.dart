import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class LoginClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.05, size.height * 0.45,
        size.width * 0.3, size.height * 0.45);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.45,
        size.width * 0.8, size.height * 0.45);
    path.quadraticBezierTo(size.width * 0.95, size.height * 0.45,
        size.width , size.height * 0.5);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

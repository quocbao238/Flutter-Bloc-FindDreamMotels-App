import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class LoginClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  double heightNeed = 0.43;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * heightNeed);
    path.quadraticBezierTo(size.width * 0.05, size.height * (heightNeed + 0.05),
        size.width * 0.3, size.height * (heightNeed + 0.05));
    path.quadraticBezierTo(size.width * 0.3, size.height * (heightNeed + 0.05),
        size.width * 0.8, size.height * (heightNeed + 0.05));
    path.quadraticBezierTo(size.width * 0.95, size.height * (heightNeed + 0.05),
        size.width, size.height * (heightNeed + 0.1));
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HomeClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  final double heightNeed;
  HomeClipPath(this.heightNeed);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * heightNeed);
    path.quadraticBezierTo(size.width * 0.05, size.height * (heightNeed + 0.05),
        size.width * 0.3, size.height * (heightNeed + 0.05));
    path.quadraticBezierTo(size.width * 0.3, size.height * (heightNeed + 0.05),
        size.width * 0.8, size.height * (heightNeed + 0.05));
    path.quadraticBezierTo(size.width * 0.95, size.height * (heightNeed + 0.05),
        size.width, size.height * (heightNeed + 0.1));
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

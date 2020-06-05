import 'package:flutter/material.dart';

class Size {
  Size._();
  static double getHeight;
  static double getWidth;
  static double scaleTxt;
  static double statusBar;
  static double padding;
}

class AppColor {
  AppColor._();
  static Color backgroundColor = Color.fromRGBO(211, 220, 240, 1);
  static Color whiteColor = Colors.white;
}

class StyleText {
  StyleText._();

  static TextStyle header20White = TextStyle(
    color: Colors.white,
    fontSize: 20.0 * Size.scaleTxt,
    fontWeight: FontWeight.bold,
  );

  static TextStyle header20Black = TextStyle(
    color: Colors.black,
    fontSize: 20.0 * Size.scaleTxt,
    fontWeight: FontWeight.bold,
  );

    static TextStyle subhead18Black500 = TextStyle(
    color: Colors.black,
    fontSize: 18.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

    static TextStyle subhead18GreenMixBlue = TextStyle(
    color: Color.fromRGBO(44, 156, 162, 1),
    fontSize: 18.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subhead16White500 = TextStyle(
    color: Colors.white,
    fontSize: 16.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subhead16Black500 = TextStyle(
    color: Colors.black,
    fontSize: 16.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

    static TextStyle subhead16GreenMixBlue = TextStyle(
    color: Color.fromRGBO(44, 156, 162, 1),
    fontSize: 16.0 * Size.scaleTxt,
    fontWeight: FontWeight.w500,
  );

  static TextStyle content14WhiteNormal = TextStyle(
    color: Colors.white,
    fontSize: 14.0 * Size.scaleTxt,
    fontWeight: FontWeight.normal,
  );

  static TextStyle content14White400 = TextStyle(
    color: Colors.white,
    fontSize: 14.0 * Size.scaleTxt,
    fontWeight: FontWeight.w400,
  );

  static TextStyle content14Black400 = TextStyle(
    color: Colors.black,
    fontSize: 14.0 * Size.scaleTxt,
    fontWeight: FontWeight.w400,
  );
}

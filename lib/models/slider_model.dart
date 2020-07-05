import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:flutter/material.dart';

class SlideData {
  String title;
  String description;
  String pathImage;
  TextStyle styleTitle;
  TextStyle styleDescription;

  SlideData(
      {this.title,
      this.description,
      this.pathImage,
      this.styleTitle,
      this.styleDescription});
}

List<SlideData> slideData = [
  SlideData(
      title: "",
      description:
          "Greet, register, and assign rooms to guests of hotels or motel",
      pathImage: AppSetting.slider1,
      styleTitle: StyleText.styleTitle,
      styleDescription: StyleText.styleDescription),
  SlideData(
      title: "",
      description:
          "Keep records of room availability and guests' accounts, manually or using computers",
      pathImage: AppSetting.slider2,
      styleTitle: StyleText.styleTitle,
      styleDescription: StyleText.styleDescription),
  SlideData(
      title: "",
      description:
          "Review accounts and charges with guests during the check out process",
      pathImage: AppSetting.slider3,
      styleTitle: StyleText.styleTitle,
      styleDescription: StyleText.styleDescription),
  SlideData(
      title: "",
      description: "Arrange tours, taxis, and restaurants for customers",
      pathImage: AppSetting.slider4,
      styleTitle: StyleText.styleTitle,
      styleDescription: StyleText.styleDescription),
];

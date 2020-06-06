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
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa",
      pathImage: "assets/sliderApp/introSlider1.png",
      styleTitle: StyleText.styleTitle,
      styleDescription: StyleText.styleDescription),
  SlideData(
      title: "",
      description:
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa",
      pathImage: "assets/sliderApp/introSlider2.png",
      styleTitle: StyleText.styleTitle,
      styleDescription: StyleText.styleDescription),
  SlideData(
      title:
          "",
      description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa...",
      pathImage: "assets/sliderApp/introSlider3.png",
      styleTitle: StyleText.styleTitle,
      styleDescription: StyleText.styleDescription),
  SlideData(
      title:
          "",
      description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa...",
      pathImage: "assets/sliderApp/introSlider4.png",
      styleTitle: StyleText.styleTitle,
      styleDescription: StyleText.styleDescription),
];

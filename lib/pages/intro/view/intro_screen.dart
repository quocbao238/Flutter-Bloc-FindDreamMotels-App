import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/models/slider_model.dart';
import 'package:findingmotels/pages/login/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/dot_animation_enum.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<Slide> slides = new List();
  Function goToTab;
  @override
  void initState() {
    super.initState();
    slideData.forEach((data) {
      slides.add(Slide(
          title: data.title,
          styleTitle: data.styleTitle,
          description: data.description,
          styleDescription: data.styleDescription,
          pathImage: data.pathImage));
    });
  }

  void onDonePress() {
    Navigator.of(context)
        .pushReplacement(new MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  void onTabChangeCompleted(index) {}

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: AppColor.colorBlue156,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(Icons.done, color: AppColor.colorBlue156);
  }

  Widget renderSkipBtn() {
    return Text(
      "SKIP",
      style: TextStyle(color: AppColor.colorBlue156),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        child: ListView(
          children: <Widget>[
            GestureDetector(
                child: Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
              child: Image.asset(
                currentSlide.pathImage,
                width: 300.0,
                height: 300.0,
                fit: BoxFit.scaleDown,
              ),
            )),
            Container(
              child: Text(
                currentSlide.title,
                style: currentSlide.styleTitle,
                textAlign: TextAlign.center,
              ),
              margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            ),
            Container(
              child: Text(
                currentSlide.description,
                style: currentSlide.styleDescription,
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            ),
          ],
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomPadding: false,
    body: _introSlider(),
    );
  }

  Widget _introSlider() => IntroSlider(
        slides: this.slides,
        // Skip button
        renderSkipBtn: this.renderSkipBtn(),
        colorSkipBtn: AppColor.backgroundColor,
        highlightColorSkipBtn: AppColor.colorBlue156,

        // Next button
        renderNextBtn: this.renderNextBtn(),

        // Done button
        renderDoneBtn: this.renderDoneBtn(),
        onDonePress: this.onDonePress,
        colorDoneBtn: AppColor.backgroundColor,
        highlightColorDoneBtn: Color(0xffffcc5c),

        // Dot indicator
        colorDot: AppColor.colorBlue156,
        colorActiveDot: AppColor.backgroundColor,

        sizeDot: 13.0,
        typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

        // Tabs
        listCustomTabs: this.renderListCustomTabs(),
        backgroundColorAllSlides: AppColor.colorClipPath,
        refFuncGoToTab: (refFunc) {
          this.goToTab = refFunc;
        },

        // Show or hide status bar
        shouldHideStatusBar: false,

        // On tab change completed
        onTabChangeCompleted: this.onTabChangeCompleted,
      );
}

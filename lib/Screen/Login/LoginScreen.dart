import 'package:findingmotels/ConfigApp/sizeScreen.dart';
import 'package:findingmotels/Screen/ClipPathCustome/loginClipPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String imageUrl = 'assets/loginSvg.svg';
  bool isSelect = true;

  @override
  Widget build(BuildContext context) {
    Size.getHeight = MediaQuery.of(context).size.height;
    Size.getWidth = MediaQuery.of(context).size.width;
    Size.scaleTxt = MediaQuery.of(context).textScaleFactor;
    Size.statusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: <Widget>[
          buildBackground(Size.getHeight),
          buidImage(Size.getHeight),
          buildPageView(Size.getHeight, Size.getWidth)
        ],
      ),
    );
  }

  Widget buildPageView(double height, double width) {
    return Positioned.fill(
        child: Container(
      margin: EdgeInsets.only(top: height * 0.42),
      child: Column(
        children: <Widget>[
          buildIcon(height, width),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(bottom: height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    buildTitleLogin(),
                    buildTitleEmail(width),
                    buildTFFEmail(width),
                    buildTitlePass(width),
                    buildTFFPass(width),
                    buildLoginForgot(width, height),
                    buildLoginButton(height, width),
                    buildForgetAccount(height),
                  ],
                )),
          )
        ],
      ),
    ));
  }

  Widget buildTitleLogin() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0, left: 8.0),
      child: Center(
        child: Text("Or login with email and phone number",
            style: StyleText.subhead16Black500),
      ),
    );
  }

  Widget buildTitleEmail(double width) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
        width: width,
        child: Text("Email/PhoneNumber",
            textAlign: TextAlign.start, style: StyleText.content14Black400),
      ),
    );
  }

  Widget buildTFFPass(double width) {
    return Container(
        margin: EdgeInsets.only( left: width * 0.04, right: width * 0.04),
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding:
                const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          style: new TextStyle(
            fontSize: 16.0 * Size.scaleTxt,
            fontFamily: "Poppins",
          ),
        ));
  }

  Widget buildTitlePass(double width) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
        width: width,
        child: Text(
          "Password",
          textAlign: TextAlign.start,
          style: StyleText.content14Black400
        ),
      ),
    );
  }

  Widget buildTFFEmail(double width) {
    return Container(
        margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
        child: TextFormField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding:
                const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          style: new TextStyle(
            fontSize: 16.0 * Size.scaleTxt,
            fontFamily: "Poppins",
          ),
        ));
  }

  Widget buildLoginForgot(double width, double height) {
    return Container(
      margin:
          EdgeInsets.only(top: 8.0, left: width * 0.08, right: width * 0.08),
      height: height * 0.03,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                isSelect = !isSelect;
              });
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        width: height * 0.03,
                        height: height * 0.03,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1.5,
                                color: isSelect ? Colors.red : Colors.grey)),
                      ),
                      Container(
                        width: height * 0.015,
                        height: height * 0.015,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: isSelect ? Colors.red : null,
                            border: Border.all(
                                width: 1.5,
                                color: isSelect ? Colors.red : Colors.grey)),
                      )
                    ],
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "Keep me logged in",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "Fogot pasword?",
            style: TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(44, 156, 162, 1),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginButton(double height, double width) {
    return Container(
      height: height * 0.06,
      width: width * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.red),
      child: Center(
        child: Text(
          "LOGIN",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildForgetAccount(double height) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: height * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Don't have an account? ",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 18.0,
                color: Color.fromRGBO(44, 156, 162, 1),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
    );
  }

  Widget buildIcon(double height, double width) {
    return Container(
      height: height * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: width * 0.30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white),
            child: Center(
              child: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/googleIcon.png', fit: BoxFit.fill),
              ),
            ),
          ),
          SizedBox(width: width * 0.03),
          Container(
            width: width * 0.30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white),
            child: Center(
              child: Container(
                width: 25,
                height: 25,
                child: Image.asset('assets/facebookIcon.png', fit: BoxFit.fill),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buidImage(double height) {
    return Positioned.fill(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            height: height * 0.35,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: (Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // SafeArea(
                //   child: Container(
                //     // margin: EdgeInsets.only(top: height * 0.),
                //     child: Center(
                //       child: Text(
                //         "Login with Account",
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 30.0,
                //             fontWeight: FontWeight.w500,
                //             letterSpacing: 2.0),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: height * 0.06),
                Expanded(
                  child: SvgPicture.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    ));
  }

  Widget buildBackground(double height) {
    return Positioned.fill(
      child: ClipPath(
        child: Container(
          color: Color.fromRGBO(9, 92, 113, 1),
        ),
        clipper: LoginClipPath(),
      ),
    );
  }
}

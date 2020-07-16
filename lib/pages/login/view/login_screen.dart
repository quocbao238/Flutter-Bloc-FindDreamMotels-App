import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/drawer/view/drawer_page.dart';
import 'package:findingmotels/pages/login/bloc/login_bloc.dart';
import 'package:findingmotels/pages/register/view/register_screen.dart';
import 'package:findingmotels/widgets/Animation/fadedAnimation.dart';
import 'package:findingmotels/widgets/clip_path_custom/loginClipPath.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String imageUrl = AppSetting.loginImg;
  bool isSelect = true;
  GlobalKey loginGlobalKey = GlobalKey();
  TextEditingController controllerEmail;
  TextEditingController controllerPassword;

  @override
  void initState() {
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                Navigator.of(context)
                    .pushReplacement(new MaterialPageRoute(builder: (context) {
                  return DrawerDashBoard();
                }));
              } else if (state is LoginFailState) {
                showToast(state.message);
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) => _body(state))));
  }

  Widget _body(LoginState state) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: loginGlobalKey,
          backgroundColor: AppColor.backgroundColor,
          body: Stack(
            children: <Widget>[
              _background(Size.getHeight),
              _pageView(Size.getHeight, Size.getWidth),
            ],
          ),
        ),
        state is LoginLoadingState
            ? LoadingWidget()
            : const SizedBox(
                width: 1,
              ),
      ],
    );
  }

  Widget _pageView(double height, double width) => Positioned.fill(
          child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeAnimation(0.1, _image(height)),
              FadeAnimation(0.2, _btnGoogleFacebook(height, width)),
              FadeAnimation(0.3, _titleLogin()),
              FadeAnimation(0.4, _titleEmail(width)),
              FadeAnimation(0.5, _tffmail(width)),
              FadeAnimation(0.6, _titlepaw(width)),
              FadeAnimation(0.7, _tffpaw(width)),
              FadeAnimation(0.8, _forgotpaw(width, height)),
              FadeAnimation(0.9, _btnlogin(height, width)),
              FadeAnimation(1, _btnsignup(height)),
            ],
          ),
        ),
      ));

  Widget _image(double height) => Container(
        color: Colors.transparent,
        height: height * 0.35,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: height * 0.06),
            Expanded(
              child: SvgPicture.asset(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ],
        )),
      );

  Widget _titleLogin() => Container(
        margin: EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0, left: 8.0),
        child: Center(
          child: Text("Or login with email and phone number",
              style: StyleText.content14Black400),
        ),
      );

  Widget _titleEmail(double width) => Container(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
          width: width,
          child: Text("Email/PhoneNumber",
              textAlign: TextAlign.start, style: StyleText.content14Black400),
        ),
      );

  Widget _tffpaw(double width) => Container(
      margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
      child: TextFormField(
        obscureText: true,
        controller: controllerPassword,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding:
              const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 12.0),
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

  Widget _titlepaw(double width) => Container(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
          width: width,
          child: Text("Password",
              textAlign: TextAlign.start, style: StyleText.content14Black400),
        ),
      );

  Widget _tffmail(double width) => Container(
      margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
      child: TextFormField(
        controller: controllerEmail,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding:
              const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
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

  Widget _forgotpaw(double width, double height) => Container(
        margin: EdgeInsets.only(
            top: 12.0, left: width * 0.08, right: width * 0.08, bottom: 12.0),
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

  Widget _btnlogin(double height, double width) => InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          BlocProvider.of<LoginBloc>(loginGlobalKey.currentContext).add(
              LoginButtonPressedEvent(
                  email: controllerEmail.text.trim(),
                  password: controllerPassword.text.trim()));
        },
        child: Container(
          height: height * 0.065,
          width: width * 0.65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.red),
          child: Center(
            child: Text("Login".toUpperCase(), style: StyleText.header20White),
          ),
        ),
      );

  Widget _btnsignup(double height) => InkWell(
        child: Container(
          margin: EdgeInsets.only(top: height * 0.02, bottom: height * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Don't have an account? ",
                  style: StyleText.subhead18Black500),
              Text("Sign Up", style: StyleText.subhead18GreenMixBlue),
            ],
          ),
        ),
        onTap: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => RegisterPage()));
          Navigator.of(context).pushReplacement(
            new MaterialPageRoute(
              builder: (context) {
                return RegisterPage();
              },
            ),
          );
        },
      );

  Widget _btnGoogleFacebook(double height, double width) => Container(
        margin: EdgeInsets.only(top: height * 0.075 + Size.statusBar / 2),
        height: height * 0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                BlocProvider.of<LoginBloc>(loginGlobalKey.currentContext)
                    .add(GoogleOnClickEvent());
              },
              child: Container(
                width: width * 0.30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Center(
                  child: Container(
                    width: 25,
                    height: 25,
                    child: Image.asset(AppSetting.googleIcon, fit: BoxFit.fill),
                  ),
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
                  child: Image.asset(AppSetting.facebookIcon, fit: BoxFit.fill),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _background(double height) => Positioned.fill(
        child: ClipPath(
          child: Container(
            color: AppColor.colorClipPath,
          ),
          clipper: LoginClipPath(),
        ),
      );
}

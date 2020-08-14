import 'package:country_code_picker/country_code_picker.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/drawer/view/drawer_page.dart';
import 'package:findingmotels/pages/login/bloc/login_bloc.dart';
import 'package:findingmotels/pages/register/view/register_screen.dart';
import 'package:findingmotels/pages/widgets/Animation/fadedAnimation.dart';
import 'package:findingmotels/pages/widgets/clip_path_custom/appClipPath.dart';
import 'package:findingmotels/pages/widgets/loadingWidget/loading_widget.dart';
import 'package:findingmotels/validator/validator.dart';
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
  TextEditingController controllerPhone;
  String code = "+84";
  bool isEmail = true;
  String errorPhone = "";

  @override
  void initState() {
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
    controllerPhone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controllerPhone.dispose();
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
          body: SingleChildScrollView(
            child: Container(
              height: Size.getHeight,
              child: Stack(
                children: <Widget>[
                  _background(Size.getHeight),
                  _pageView(Size.getHeight, Size.getWidth),
                ],
              ),
            ),
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
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FadeAnimation(0.1, _image(height)),
            FadeAnimation(0.2, _btnGoogleFacebook(height, width)),
            FadeAnimation(0.3, _titleLogin()),
            FadeAnimation(
                0.4, isEmail ? _titleEmail(width) : _titlePhoneNumber(width)),
            FadeAnimation(
                0.5, isEmail ? _tffmail(width) : _titlePhoneNumber2(width)),
            FadeAnimation(0.6, isEmail ? _titlepaw(width) : _countryCode()),
            FadeAnimation(0.7, isEmail ? _tffpaw(width) : SizedBox()),
            FadeAnimation(
                0.8, isEmail ? _forgotpaw(width, height) : SizedBox()),
            Spacer(),
            FadeAnimation(0.9, _btnlogin(height, width)),
            FadeAnimation(
                1,
                isEmail
                    ? _btnsignup(height)
                    : Container(margin: EdgeInsets.only(bottom: 16.0))),
          ],
        ),
      ));

  Widget _countryCode() => Container(
        margin: EdgeInsets.only(
            top: 16.0, left: Size.getWidth * 0.04, right: Size.getWidth * 0.04),
        height: 40.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              // color: Colors.red,
              child: CountryCodePicker(
                onChanged: (callBack) {
                  code = callBack.code;
                },
                flagWidth: 40.0,
                favorite: ['+84', 'vi'],
                initialSelection: '+84',
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
              ),
            ),
            SizedBox(width: 4.0),
            Expanded(
                child: Container(
              // color: Colors.blue,
              child: TextFormField(
                controller: controllerPhone,
                onChanged: (v) {
                  // print(code + controllerPhone.text);
                  // // setState(() {
                  // errorPhone = Valid.isPhoneNumber(controllerPhone.text)
                  //     ? ""
                  //     : "Not valid phone number!";
                  // print(errorPhone);
                  // // });
                },
                decoration: InputDecoration(
                    fillColor: AppColor.colorClipPath,
                    hintText: 'Mobile number',
                    helperText: 'Mobile number',
                    focusColor: AppColor.colorClipPath,
                    labelStyle: StyleText.subhead16GreenMixBlue
                        .copyWith(color: AppColor.colorClipPath)),
                keyboardType: TextInputType.phone,
                style: new TextStyle(
                  fontSize: 16.0 * Size.scaleTxt,
                  fontFamily: "Poppins",
                ),
              ),
            ))
          ],
        ),
      );

  Widget _titlePhoneNumber(double width) => Container(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
          width: width,
          child: Text("Enter your mobile nubmer",
              textAlign: TextAlign.start,
              style: StyleText.header24Black.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.black87)),
        ),
      );

  Widget _titlePhoneNumber2(double width) => Container(
        padding: EdgeInsets.only(top: 4.0, right: width * 0.2),
        child: Container(
          margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
          width: width,
          child: Text(
              "Please confirm your country code and enter your mobile number",
              textAlign: TextAlign.start,
              style: StyleText.subhead18Grey400
                  .copyWith(fontWeight: FontWeight.w600)),
        ),
      );

  Widget _titleLogin() => Container(
        margin: EdgeInsets.only(right: 8.0, left: 8.0),
        height: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                setState(() => isEmail = true);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: Row(
                  children: <Widget>[
                    Text("Login with ", style: StyleText.content14Black400),
                    Text("Email",
                        style: StyleText.content14Black400.copyWith(
                            color: isEmail
                                ? AppColor.alerBtnColor
                                : Colors.black)),
                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                setState(() => isEmail = false);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                child: Row(
                  children: <Widget>[
                    Text(" or ", style: StyleText.content14Black400),
                    Text("Phone Number",
                        style: StyleText.content14Black400.copyWith(
                            color: !isEmail
                                ? AppColor.alerBtnColor
                                : Colors.black)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _titleEmail(double width) => Container(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
          width: width,
          child: Text("Email",
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
          isEmail
              ? BlocProvider.of<LoginBloc>(loginGlobalKey.currentContext).add(
                  LoginButtonPressedEvent(
                      email: controllerEmail.text.trim(),
                      password: controllerPassword.text.trim()))
              : BlocProvider.of<LoginBloc>(loginGlobalKey.currentContext)
                  .add(ContinuePhoneEvent(controllerPhone.text.trim()));
        },
        child: Container(
          height: height * 0.08,
          width: isEmail ? width * 0.65 : width * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isEmail ? 30 : 5),
              color: Colors.red),
          child: Center(
            child: Text(isEmail ? "Login" : "Continue".toUpperCase(),
                style: StyleText.header20Whitew500
                    .copyWith(color: Colors.white70)),
          ),
        ),
      );

  Widget _btnsignup(double height) => InkWell(
        child: Container(
          margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
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
          Navigator.of(context).pushReplacement(
            new MaterialPageRoute(
              builder: (context) {
                return RegisterPage();
              },
            ),
          );
        },
      );

  Widget _image(double height) => Container(
        height: height * 0.32,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SvgPicture.asset(
          imageUrl,
          fit: BoxFit.fill,
        ),
      );

  Widget _btnGoogleFacebook(double height, double width) => Container(
        // margin: EdgeInsets.only(top: height * 0.08 + Size.statusBar / 2),
        margin: EdgeInsets.only(top: height * 0.020),
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
                    borderRadius: BorderRadius.circular(isEmail ? 30 : 5),
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
            InkWell(
              onTap: () {
                BlocProvider.of<LoginBloc>(loginGlobalKey.currentContext)
                    .add(FacebookOnClickEvent());
              },
              child: Container(
                width: width * 0.30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isEmail ? 30 : 5),
                    color: Colors.white),
                child: Center(
                  child: Container(
                    width: 25,
                    height: 25,
                    child:
                        Image.asset(AppSetting.facebookIcon, fit: BoxFit.fill),
                  ),
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

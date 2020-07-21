import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/drawer/view/drawer_page.dart';
import 'package:findingmotels/pages/login/view/login_screen.dart';
import 'package:findingmotels/pages/register/bloc/userreg_bloc.dart';
import 'package:findingmotels/widgets/Animation/fadedAnimation.dart';
import 'package:findingmotels/widgets/clip_path_custom/registerClipPath.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String imageUrl = AppSetting.registerImg;
  GlobalKey registerGlobalKey;
  TextEditingController controllerEmail;
  TextEditingController controllerPassword;
  TextEditingController controllerUserName;

  @override
  void initState() {
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
    controllerUserName = TextEditingController();
    registerGlobalKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    controllerUserName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserregBloc(),
      child: BlocListener<UserregBloc, UserregState>(
        listener: (context, state) {
          if (state is UserRegSuccessful) {
            Navigator.of(context)
                .pushReplacement(new MaterialPageRoute(builder: (context) {
              return DrawerDashBoard();
            }));
          } else if (state is UserRegFailure) {
            showToast(state.message);
          }
        },
        child: BlocBuilder<UserregBloc, UserregState>(
          builder: (context, state) => Stack(
            children: <Widget>[
              Scaffold(
                key: registerGlobalKey,
                backgroundColor: Color.fromRGBO(211, 220, 240, 1),
                body: Stack(
                  children: <Widget>[
                    buildBackground(Size.getHeight),
                    buildPageView(Size.getHeight, Size.getWidth),
                  ],
                ),
              ),
              state is UserRegLoading ? LoadingWidget() : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageView(double height, double width) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FadeAnimation(0.1, buildTitleImage(height)),
              FadeAnimation(0.2, buildTitleUserName(width, height)),
              FadeAnimation(0.3, buildTFFUser(width)),
              FadeAnimation(0.4, buildTitleEmail(width)),
              FadeAnimation(0.5, buildTFFEmail(width)),
              FadeAnimation(0.6, buildTitlePass(width)),
              FadeAnimation(0.8, buildTFFPass(width)),
              FadeAnimation(0.10, buildRegisterEmail(width, height)),
              FadeAnimation(1.2, buildLoginText(height))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitleUserName(double width, double height) {
    return Container(
      // margin: EdgeInsets.only(top: height * 0.07),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
        width: width,
        child: Text("UserName",
            textAlign: TextAlign.start, style: StyleText.content14Black400),
      ),
    );
  }

  Widget buildTFFUser(double width) {
    return Container(
        margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
        child: TextFormField(
          controller: controllerUserName,
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
  }

  Widget buildTitleEmail(double width) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 3000),
      curve: Curves.easeIn,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
        width: width,
        child: Text("Email/PhoneNumber",
            textAlign: TextAlign.start, style: StyleText.content14Black400),
      ),
    );
  }

  Widget buildTFFEmail(double width) {
    return Container(
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
  }

  Widget buildTitlePass(double width) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
        width: width,
        child: Text("Password",
            textAlign: TextAlign.start, style: StyleText.content14Black400),
      ),
    );
  }

  Widget buildTFFPass(double width) {
    return Container(
        margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
        child: TextFormField(
          obscureText: true,
          controller: controllerPassword,
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
  }

  Widget buildRegisterEmail(double width, double height) {
    return InkWell(
      onTap: () {
        BlocProvider.of<UserregBloc>(registerGlobalKey.currentContext).add(
            SignUpButtonPressed(
                email: controllerEmail.text.trim(),
                password: controllerPassword.text.trim(),
                userName: controllerUserName.text.trim()));
      },
      child: Container(
        width: width * 0.75,
        height: height * 0.07,
        margin: EdgeInsets.only(top: height * 0.035),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.red,
        ),
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FittedBox(child: Text("Register", style: StyleText.header20White)),
          ],
        ),
      ),
    );
  }

  Widget buildLoginText(double height) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: height * 0.03, bottom: height * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Already have an account? ",
                style: StyleText.subhead18Black500),
            Text("Login", style: StyleText.subhead18GreenMixBlue)
          ],
        ),
      ),
    );
  }

  Widget buildBackground(double height) {
    return Positioned.fill(
      child: Container(
        height: height * 0.8,
        child: FadeAnimation(
            0.1,
            ClipPath(
              child: Container(
                color: AppColor.colorClipPath
              ),
              clipper: RegisterClipPath(),
            )),
      ),
    );
  }

  Widget buildTitleImage(double height) {
    return Container(
      color: Colors.transparent,
      height: height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: (Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: height * 0.04),
          Expanded(
            child: SvgPicture.asset(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ],
      )),
    );
  }
}

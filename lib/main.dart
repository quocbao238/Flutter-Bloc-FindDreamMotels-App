import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:findingmotels/blocs/auth_bloc/auth_bloc_bloc.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/mainDemoMap.dart';
import 'package:findingmotels/pages/drawer/view/drawer_page.dart';
import 'package:findingmotels/pages/intro/view/intro_screen.dart';
import 'package:findingmotels/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseService.setupFirebase();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(
    OKToast(
      textStyle: TextStyle(fontSize: 19.0, color: Colors.white),
      textPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      backgroundColor: Colors.black54,
      radius: 10.0,
      animationCurve: Curves.easeIn,
      position: ToastPosition.bottom,
      animationBuilder: Miui10AnimBuilder(),
      animationDuration: Duration(milliseconds: 100),
      duration: Duration(seconds: 1),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Find Dream Hotel',
        theme: ThemeData(primarySwatch: Colors.blue),
        // home: App(),
        home: MapSample(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    getSizeApp(context);
    return BlocProvider(
      create: (context) => AuthBloc()..add(AppStartedEvent()),
      child: BlocListener<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            debugPrint("AuthenticatedState");
            Navigator.of(context)
                .pushReplacement(new MaterialPageRoute(builder: (context) {
              return DrawerDashBoard();
            }));
          } else if (state is UnauthenticatedState) {
            debugPrint("UnauthenticatedState");
            Navigator.of(context)
                .pushReplacement(new MaterialPageRoute(builder: (context) {
              return IntroPage();
            }));
          }
        },
        child: BlocBuilder<AuthBloc, AuthBlocState>(
          builder: (context, state) {
            return _splashscreen();
          },
        ),
      ),
    );
  }

  Widget _splashscreen() => Scaffold(
        backgroundColor: AppColor.colorClipPath,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
                child: SvgPicture.asset(
                  AppSetting.logoutImg,
                  // width: 300.0,
                  height: 300.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    color: Colors.transparent,
                    height: 40.0,
                    child: Center(
                        child: SpinKitCircle(
                            duration: Duration(milliseconds: 2000),
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                    color: index.isEven
                                        ? Colors.red
                                        : Colors.white),
                              );
                            }))),
                FadeAnimatedTextKit(
                    text: ["Loading...."],
                    textStyle: StyleText.header24BWhitew400),
              ],
            )
          ],
          // child: Center(
          //   child: LoadingWidget(),
          // ),
        ),
      );
}

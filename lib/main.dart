import 'package:findingmotels/blocs/auth_bloc/auth_bloc_bloc.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/services/firebase_service.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'pages/drawer/view/drawer_page.dart';
import 'pages/intro/view/intro_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseService.setupFirebase();
  runApp(
    OKToast(
      textStyle: TextStyle(fontSize: 19.0, color: Colors.white),
      textPadding: EdgeInsets.symmetric(horizontal: 8.0),
      backgroundColor: Colors.black54,
      radius: 10.0,
      animationCurve: Curves.easeIn,
      position: ToastPosition.bottom,
      animationBuilder: Miui10AnimBuilder(),
      animationDuration: Duration(milliseconds: 200),
      duration: Duration(seconds: 3),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Find Accommodation',
        // theme: ThemeData(primarySwatch: Colors.blue),
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light),
          child: App(),
        ),
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
            return LoadingWidget();
          },
        ),
      ),
    );
  }
}

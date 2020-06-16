import 'package:findingmotels/blocs/auth_bloc/auth_bloc_bloc.dart';
import 'package:findingmotels/repository/user_repository.dart';
import 'package:findingmotels/screen_app/custom_widget/loading_widget.dart';
import 'package:findingmotels/screen_app/ui/dashboard/dashboard_screen.dart';
import 'package:findingmotels/screen_app/ui/introslider/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await innitDB();

  runApp(OKToast(
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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: App(),
      // home: ListViewStudent(),
    ),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc()..add(AppStartedEvent(userRepository: userRepository)),
      child: BlocListener<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            debugPrint("AuthenticatedState");
            Navigator.of(context)
                .pushReplacement(new MaterialPageRoute(builder: (context) {
              return DashboardPage(userRepository: userRepository);
            }));
          } else if (state is UnauthenticatedState) {
            debugPrint("UnauthenticatedState");
            Navigator.of(context)
                .pushReplacement(new MaterialPageRoute(builder: (context) {
              return IntroPage(userRepository: userRepository);
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

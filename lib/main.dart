import 'package:findingmotels/blocs/auth_bloc/auth_bloc_bloc.dart';
import 'package:findingmotels/repository/user_repository.dart';
import 'package:findingmotels/screen_app/custom_widget/loading_widget.dart';
import 'package:findingmotels/screen_app/ui/introslider/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Find Accommodation',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: App(),
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
            // Navigator.of(context)
            //     .pushReplacement(new MaterialPageRoute(builder: (context) {
            //   return HomePageParent(
            //       user: state.user, userRepository: userRepository);
            // }));
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
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/tutorial/bloc/tutorial_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  GlobalKey globalKey;

  @override
  void initState() {
    globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TutorialBloc(),
        child: BlocListener<TutorialBloc, TutorialState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<TutorialBloc, TutorialState>(
                builder: (context, state) => _scaffold())));
  }

  void blocListener(TutorialState state, BuildContext context) {}

  Widget _scaffold() => Scaffold(
        key: globalKey,
        backgroundColor: AppColor.backgroundColor,
      );
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tutorial_event.dart';
part 'tutorial_state.dart';

class TutorialBloc extends Bloc<TutorialEvent, TutorialState> {
  @override
  TutorialState get initialState => TutorialInitial();

  @override
  Stream<TutorialState> mapEventToState(
    TutorialEvent event,
  ) async* {
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tutorial_event.dart';
part 'tutorial_state.dart';

class TutorialBloc extends Bloc<TutorialEvent, UserEditlState> {
  @override
  UserEditlState get initialState => TutorialInitial();

  @override
  Stream<UserEditlState> mapEventToState(
    TutorialEvent event,
  ) async* {
  }
}

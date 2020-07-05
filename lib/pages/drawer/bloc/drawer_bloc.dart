import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  @override
  DrawerState get initialState => DrawerInitial();

  @override
  Stream<DrawerState> mapEventToState(
    DrawerEvent event,
  ) async* {
    if (event is MenuEvent) {
      yield event.isCollapsed
          ? MeunuOpenState()
          : MenuCloseState();
    }
  }
}

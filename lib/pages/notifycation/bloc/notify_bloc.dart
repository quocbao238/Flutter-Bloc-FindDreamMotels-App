import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notify_event.dart';
part 'notify_state.dart';

class NotifyBloc extends Bloc<NotifyEvent, NotifyState> {
  @override
  NotifyState get initialState => NotifyInitial();

  @override
  Stream<NotifyState> mapEventToState(
    NotifyEvent event,
  ) async* {}
}

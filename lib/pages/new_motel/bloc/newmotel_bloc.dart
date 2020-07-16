import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'newmotel_event.dart';
part 'newmotel_state.dart';

class NewmotelBloc extends Bloc<NewmotelEvent, NewmotelState> {
   @override
  NewmotelState get initialState => NewmotelInitial();

  @override
  Stream<NewmotelState> mapEventToState(
    NewmotelEvent event,
  ) async* {
  }
}

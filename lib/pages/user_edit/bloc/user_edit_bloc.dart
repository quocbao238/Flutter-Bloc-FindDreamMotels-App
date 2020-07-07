import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_edit_event.dart';
part 'user_edit_state.dart';

class UserEditBloc extends Bloc<UserEditEvent, UserEditState> {
  @override
  UserEditState get initialState => UserEditInitial();
  @override
  Stream<UserEditState> mapEventToState(
    UserEditEvent event,
  ) async* {
  }
}

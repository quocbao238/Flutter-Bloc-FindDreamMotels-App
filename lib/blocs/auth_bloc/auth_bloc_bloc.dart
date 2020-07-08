import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  @override
  AuthBlocState get initialState => AuthBlocInitial();

  @override
  Stream<AuthBlocState> mapEventToState(AuthBlocEvent event) async* {
    if (event is AppStartedEvent) {
      yield AuthenLoadingState();
      try {
        var isSignedIn = await ConfigApp.firebaseAuth.isSignedIn();
        if (isSignedIn) {
          var user = await ConfigApp.firebaseAuth.getCurrentUser();
          ConfigApp.fbuser = user;
          yield AuthenticatedState(user: user);
        } else {
          yield UnauthenticatedState();
        }
      } catch (e) {
        yield UnauthenticatedState();
      }
    }
  }
}

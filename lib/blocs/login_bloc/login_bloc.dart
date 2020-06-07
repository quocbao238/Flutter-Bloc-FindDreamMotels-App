import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/repository/user_repository.dart';
import 'package:findingmotels/validator/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;

  LoginBloc({this.userRepository});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressedEvent) {
      yield LoginLoadingState();
      if (Valid.isEmail(event.email) || Valid.isPhoneNumber(event.email)) {
        if (event.password != "") {
          try {
            var user = await userRepository.signInEmailAndPassword(
                event.email, event.password);
            if (user != null) {
              ConfigApp.fbuser = user;
              yield LoginSuccessState(user: user);
            } else {
              yield LoginFailState(
                  message:
                      "Password is incorrect! Please check again");
            }
          } catch (e) {
            yield LoginFailState(message: "Có lỗi xảy ra vui lòng thử lại");
          }
        } else {
          yield LoginFailState(message: "Có lỗi xảy ra vui lòng thử lại");
        }
      } else {
        yield LoginFailState(
            message: "Email or phonenumber format is incorrect");
      }
    } else if (event is GotoSignUpPageEvent) {
      yield GotoSignUpPageState();
    } else if (event is HideShowPasswordEvent) {
      yield HideShowPasswordState(isHide: event.isHide);
    } else if (event is GoogleOnClickEvent) {
      try {
        var user = await userRepository.loginWithGoogle();
        if (user != null) {
          ConfigApp.fbuser = user;
          ConfigApp.userRepository = userRepository;
          yield LoginSuccessState(user: user);
        }
        yield LoginFailState(
            message: "Email or password is incorrect! Please check again");
      } catch (e) {
        yield LoginFailState(message: "Có lỗi xảy ra vui lòng thử lại");
      }
    }
    yield LoginInitial();
  }
}

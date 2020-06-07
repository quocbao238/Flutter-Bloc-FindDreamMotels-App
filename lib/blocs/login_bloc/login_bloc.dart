import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/repository/user_repository.dart';
import 'package:findingmotels/validator/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              print(user);
              yield LoginSuccessState(user: user);
            } else {
              yield LoginFailState(message:"Email or password is incorrect! Please check again");
            }
          } catch (e) {
            yield LoginFailState(message: "Có lỗi xảy ra vui lòng thử lại");
          }
        } else {
          yield LoginFailState(message: "Có lỗi xảy ra vui lòng thử lại");
        }
      } else {
        yield LoginFailState(message: "Email or phonenumber format is incorrect");
      }
    } else if (event is GotoSignUpPageEvent) {
      yield GotoSignUpPageState();
    } else if (event is HideShowPasswordEvent) {
      yield HideShowPasswordState(isHide: event.isHide);
    }
    yield LoginInitial();
  }
}

part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => null;
}

class LoginButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;
  LoginButtonPressedEvent({this.email, this.password});
}

class GoogleOnClickEvent extends LoginEvent {}

class FacebookOnClickEvent extends LoginEvent {}

class GotoSignUpPageEvent extends LoginEvent {}

class HideShowPasswordEvent extends LoginEvent {
  final bool isHide;
  HideShowPasswordEvent({this.isHide});
}

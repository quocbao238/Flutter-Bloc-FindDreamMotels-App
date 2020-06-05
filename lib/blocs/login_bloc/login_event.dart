part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;
  LoginButtonPressedEvent({this.email, this.password});
  @override
  List<Object> get props => null;
}

class GotoSignUpPageEvent extends LoginEvent {
  @override
  List<Object> get props => null;
}


class HideShowPasswordEvent extends LoginEvent {
  final bool isHide;
  HideShowPasswordEvent({this.isHide});
  @override
  List<Object> get props => null;
}

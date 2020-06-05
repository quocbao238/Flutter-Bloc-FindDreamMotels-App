part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => null;
}

class LoginSuccessState extends LoginState {
  final FirebaseUser user;
  LoginSuccessState({this.user});
  @override
  List<Object> get props => null;
}

class LoginFailState extends LoginState {
  final String message;
  LoginFailState({this.message});
  @override
  List<Object> get props => null;
}

class GotoSignUpPageState extends LoginState {
  @override
  List<Object> get props => null;
}


class HideShowPasswordState extends LoginState {
  final bool isHide;
  HideShowPasswordState({this.isHide});
  @override
  List<Object> get props => null;
}

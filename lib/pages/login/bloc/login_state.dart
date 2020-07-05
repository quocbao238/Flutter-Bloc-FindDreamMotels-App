part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => null;
}

class LoginInitial extends LoginState {
}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final FirebaseUser user;
  final UserRepository userRepository;
  LoginSuccessState({this.user, this.userRepository});
}

class LoginFailState extends LoginState {
  final String message;
  LoginFailState({this.message});
}

class GotoSignUpPageState extends LoginState {
  @override
  List<Object> get props => null;
}

class HideShowPasswordState extends LoginState {
  final bool isHide;
  HideShowPasswordState({this.isHide});
}

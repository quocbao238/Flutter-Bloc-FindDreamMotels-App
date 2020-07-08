part of 'auth_bloc_bloc.dart';

abstract class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();
}

class AppStartedEvent extends AuthBlocEvent {
  @override
  List<Object> get props => null;
}

class CheckUserEvent extends AuthBlocEvent {
  @override
  List<Object> get props => null;
}

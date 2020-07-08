part of 'userreg_bloc.dart';

abstract class UserregState extends Equatable {
  const UserregState();
}

class UserregInitial extends UserregState {
  @override
  List<Object> get props => [];
}

class UserRegLoading extends UserregState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class UserRegSuccessful extends UserregState {
  final FirebaseUser user;
  UserRegSuccessful(this.user);
  @override
  List<Object> get props => null;
}

class UserRegFailure extends UserregState {
  final String message;
  UserRegFailure({this.message});
  @override
  List<Object> get props => null;
}

class HideShowPasswordState extends UserregState {
  final bool isHide;
  HideShowPasswordState({this.isHide});
  @override
  List<Object> get props => null;
}

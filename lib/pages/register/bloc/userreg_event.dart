part of 'userreg_bloc.dart';

abstract class UserregEvent extends Equatable {
  const UserregEvent();
}

class SignUpButtonPressed extends UserregEvent {
  final String email, password, userName;
  SignUpButtonPressed({this.email, this.password, this.userName});
  @override
  List<Object> get props => throw UnimplementedError();
}


class HideShowPasswordEvent extends UserregEvent {
  final bool isHide;
  HideShowPasswordEvent({this.isHide});
  @override
  List<Object> get props => null;
}

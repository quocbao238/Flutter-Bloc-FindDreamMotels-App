part of 'user_edit_bloc.dart';

abstract class UserEditEvent extends Equatable {
  @override
  List<Object> get props => null;
  const UserEditEvent();
}

class UpdateAvatarEvent extends UserEditEvent {}

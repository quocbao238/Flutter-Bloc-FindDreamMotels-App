part of 'user_edit_bloc.dart';

abstract class UserEditState extends Equatable {
  const UserEditState();
  @override
  List<Object> get props => [];
}

class UserEditInitial extends UserEditState {}

class UpdateAvatarSucessState extends UserEditState {}

class UpdateAvatarFailState extends UserEditState {}

class LoadingState extends UserEditState{}

part of 'user_edit_bloc.dart';

abstract class UserEditEvent extends Equatable {
  @override
  List<Object> get props => null;
  const UserEditEvent();
}

class UpdateAvatarEvent extends UserEditEvent {}

class EditProfileEVent extends UserEditEvent {
  final String name;
  EditProfileEVent(this.name);
}

class ChangeStatusEditEvent extends UserEditEvent {
  final bool isEdit;
  ChangeStatusEditEvent({this.isEdit});
}

class FeatchDataEvent extends UserEditEvent {}

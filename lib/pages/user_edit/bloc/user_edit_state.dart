part of 'user_edit_bloc.dart';

abstract class UserEditState extends Equatable {
  const UserEditState();
  @override
  List<Object> get props => [];
}

class UserEditInitial extends UserEditState {}

class UpdateAvatarSucessState extends UserEditState {}

class UpdateAvatarFailState extends UserEditState {}

class LoadingState extends UserEditState {}

class ChangeStatusEditState extends UserEditState {
  final bool isEdit;
  ChangeStatusEditState(this.isEdit);
}

class FeatchDataSucessState extends UserEditState {
  final UserInfoModel userInfo;
  FeatchDataSucessState(this.userInfo);
}

class FeatchDataFailState extends UserEditState {}

class EditProfileSucessState extends UserEditState {
  final FirebaseUser fbuser;
  EditProfileSucessState(this.fbuser);
}

class EditProfileFailState extends UserEditState {}

class OnSelectAddressSucessState extends UserEditState {}

class OnSelectAddressFailState extends UserEditState {}

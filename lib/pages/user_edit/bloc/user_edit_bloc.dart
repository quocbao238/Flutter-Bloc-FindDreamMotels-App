import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oktoast/oktoast.dart';

part 'user_edit_event.dart';
part 'user_edit_state.dart';

class UserEditBloc extends Bloc<UserEditEvent, UserEditState> {
  @override
  UserEditState get initialState => UserEditInitial();
  @override
  Stream<UserEditState> mapEventToState(
    UserEditEvent event,
  ) async* {
    if (event is UpdateAvatarEvent) {
      yield LoadingState();
      String url = await ConfigApp.fbCloudStorage
          .updateAvatar(uuid: ConfigApp.fbuser.uid);
      if (url != null) {
        var fbUser = updateUserToFirebase(url, null);
        if (fbUser != null) {
          ConfigApp.fbuser = await fbUser;
          yield UpdateAvatarSucessState();
        } else {
          yield UpdateAvatarFailState();
        }
      } else {
        showToast('Update avatar fail. Please try again!');
        yield UpdateAvatarFailState();
      }
    } else if (event is ChangeStatusEditEvent) {
      yield ChangeStatusEditState(!event.isEdit);
    } else if (event is FeatchDataEvent) {
      var userInfo = UserInfo(
          name: ConfigApp?.fbuser?.displayName ?? "".toString(),
          email: ConfigApp?.fbuser?.email ?? "".toString(),
          phoneNumber:
              ConfigApp?.fbuser?.phoneNumber ?? "0981243786".toString(),
          location: "Nguyễn Công Trứ Tỉnh Lâm Đồng");
      yield userInfo != null
          ? FeatchDataSucessState(userInfo)
          : FeatchDataFailState();
    } else if (event is EditProfileEVent) {
      yield LoadingState();
      var fbUser = await updateUserToFirebase(null, event.name);
      if (fbUser != null) {
        ConfigApp.fbuser = fbUser;
        yield EditProfileSucessState(fbUser);
      } else {
        yield EditProfileFailState();
      }
    }

    yield UserEditInitial();
  }

  Future<FirebaseUser> updateUserToFirebase(String imgUrl, String name) async {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName =
        (name == null) ? ConfigApp.fbuser.displayName : name;
    updateInfo.photoUrl = (imgUrl == null) ? ConfigApp.fbuser.photoUrl : imgUrl;
    await ConfigApp.fbuser.updateProfile(updateInfo);
    await ConfigApp.fbuser.reload();
    var userSend = await ConfigApp.firebaseAuth.getCurrentUser();
    print('USERNAME IS: ${userSend.displayName}');
    return userSend;
  }
}

class UserInfo {
  String name;
  String phoneNumber;
  String email;
  String location;
  UserInfo({this.name, this.phoneNumber, this.email, this.location});
}

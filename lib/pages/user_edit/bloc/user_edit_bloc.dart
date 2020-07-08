import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
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
        var fbUser = updateUserToFirebase(url);
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
    }
  }

  Future<FirebaseUser> updateUserToFirebase(String url) async {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = ConfigApp.fbuser.displayName;
    updateInfo.photoUrl = url;
    await ConfigApp.fbuser.updateProfile(updateInfo);
    await ConfigApp.fbuser.reload();
    var userSend = await ConfigApp.firebaseAuth.getCurrentUser();
    print('USERNAME IS: ${userSend.displayName}');
    return userSend;
  }
}

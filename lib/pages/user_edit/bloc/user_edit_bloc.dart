import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/userInfo_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
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
// Update Avatar
    if (event is UpdateAvatarEvent) {
      yield LoadingState();
      String url = await ConfigApp.fbCloudStorage
          .updateAvatar(uuid: ConfigApp.fbuser.uid);
      if (url != null) {
        var fbUser = updateUserToFirebaseAuth(imgUrl: url, name: null);
        if (fbUser != null) {
          ConfigApp.fbuser = await fbUser;
          showToast('Update Avatar successful!');
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

// FeatchData
    } else if (event is FeatchDataEvent) {
      yield LoadingState();
      UserInfoModel _userInfo = await featchUserData();
      yield _userInfo != null
          ? FeatchDataSucessState(_userInfo)
          : FeatchDataFailState();
    }
// Edit profile
    else if (event is EditProfileEVent) {
      yield LoadingState();
      //Update firebase auth
      var fbUser = await updateUserToFirebaseAuth(
          imgUrl: null, name: event.userInfoModel.name);
      //Update firebase cloud;
      var userInfoModel = await updateDataToClound(event.userInfoModel);
      if (fbUser != null && userInfoModel != null) {
        ConfigApp.fbuser = fbUser;
        yield EditProfileSucessState(fbUser);
      } else {
        yield EditProfileFailState();
      }
    } else if (event is OnSelectAddressEvent) {
      LocationResult result = await showLocationPicker(
        event.context,
        AppSetting.googleMapId,
        initialCenter: ConfigApp.mylatLng,
        myLocationButtonEnabled: true,
        layersButtonEnabled: true,
      );
      print(result.address);
      print(result.latLng);

      // yield OnSelectAddressSucessState();
      // yield OnSelectAddressFailState();
    }

    yield UserEditInitial();
  }

// Update to firebase auth
  Future<FirebaseUser> updateUserToFirebaseAuth(
      {String imgUrl, String name}) async {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName =
        (name == null) ? ConfigApp.fbuser.displayName : name;
    updateInfo.photoUrl = (imgUrl == null) ? ConfigApp.fbuser.photoUrl : imgUrl;
    await ConfigApp.fbuser.updateProfile(updateInfo);
    await ConfigApp.fbuser.reload();
    var userSend = await ConfigApp.firebaseAuth.getCurrentUser();
    return userSend;
  }

// Featch Data innit
  Future<UserInfoModel> featchUserData() async {
    UserInfoModel _userInfo = UserInfoModel();
    _userInfo = null;
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection('info')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        if (f.documentID == ConfigApp.fbuser.uid)
          _userInfo = UserInfoModel.fromJson(f.data);
      });
    });
    if (_userInfo == null) _userInfo = await createUserData();
    ConfigUserInfo.phone = _userInfo.phone;
    return _userInfo;
  }

//Create userData if userInfo = null
  Future<UserInfoModel> createUserData() async {
    UserInfoModel _userInfo = UserInfoModel(
        name: ConfigApp.fbuser.displayName,
        photoUrl: ConfigApp.fbuser.photoUrl,
        email: ConfigApp.fbuser.email,
        address: ' ',
        birthday: ' ',
        phone: ' ',
        role: '0');
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection('info')
        .document(ConfigApp.fbuser.uid)
        .setData(_userInfo.toJson());
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection('info')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        if (f.documentID == ConfigApp.fbuser.uid)
          _userInfo = UserInfoModel.fromJson(f.data);
      });
    });
    return _userInfo;
  }

// Update
  Future<UserInfoModel> updateDataToClound(UserInfoModel _userInfo) async {
    UserInfoModel userInfoModel = UserInfoModel();
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection('info')
        .document(ConfigApp.fbuser.uid)
        .setData(_userInfo.toJson());
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection('info')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        if (f.documentID == ConfigApp.fbuser.uid)
          userInfoModel = UserInfoModel.fromJson(f.data);
      });
    });
    return userInfoModel;
  }
}

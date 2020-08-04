import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/userInfo_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  @override
  AuthBlocState get initialState => AuthBlocInitial();

  @override
  Stream<AuthBlocState> mapEventToState(AuthBlocEvent event) async* {
    if (event is AppStartedEvent) {
      yield AuthenLoadingState();
      try {
        await Future.delayed(Duration(seconds: 2));
        var isSignedIn = await ConfigApp.firebaseAuth.isSignedIn();
        if (isSignedIn) {
          var user = await ConfigApp.firebaseAuth.getCurrentUser();
          ConfigApp.fbuser = user;
          await featchUserData();
          yield AuthenticatedState(user: user);
        } else {
          yield UnauthenticatedState();
        }
      } catch (e) {
        yield UnauthenticatedState();
      }
    }
  }

  Future<UserInfoModel> featchUserData() async {
    UserInfoModel _userInfo = UserInfoModel();
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
    ConfigUserInfo.address = _userInfo.address;
    ConfigUserInfo.birthday = _userInfo.birthday;
    ConfigUserInfo.email = _userInfo.email;
    ConfigUserInfo.name = _userInfo.name;
    // ConfigUserInfo.userOneSignalId = await ConfigApp.oneSignalService.getOneSignalId();
    print('QB\: OneSignalId: ${ConfigUserInfo.userOneSignalId}');
    return _userInfo;
  }

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
}

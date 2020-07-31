import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/userInfo_model.dart';
import 'package:findingmotels/validator/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressedEvent) {
      yield LoginLoadingState();
      if (Valid.isEmail(event.email)) {
        if (Valid.isPassword(event.password)) {
          try {
            var user = await ConfigApp.firebaseAuth
                .signInEmailAndPassword(event.email, event.password);
            if (user != null) {
              ConfigApp.fbuser = user;
              await featchUserData();
              yield LoginSuccessState(user: user);
            } else {
              yield LoginFailState(
                  message: "Email & Password is incorrect! Please check again");
            }
          } catch (e) {
            yield LoginFailState(
                message: "An error occurred, please try again later");
          }
        } else {
          yield LoginFailState(message: "Password format is incorrect");
        }
      } else {
        yield LoginFailState(message: "Email format is incorrect");
      }
    } else if (event is GotoSignUpPageEvent) {
      yield GotoSignUpPageState();
    } else if (event is HideShowPasswordEvent) {
      yield HideShowPasswordState(isHide: event.isHide);
    } else if (event is GoogleOnClickEvent) {
      yield LoginLoadingState();
      try {
        var user = await ConfigApp.firebaseAuth.loginWithGoogle();
        if (user != null) {
          ConfigApp.fbuser = user;
          yield LoginSuccessState(user: user);
        } else {
          yield LoginFailState(
              message: "An error occurred, please try again later");
        }
      } catch (e) {
        yield LoginFailState(
            message: "An error occurred, please try again later");
      }
    }
    yield LoginInitial();
  }
}

Future<void> featchUserData() async {
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
  ConfigUserInfo.userOneSignalId =
      await ConfigApp.oneSignalService.getOneSignalId();
  print('QB\: OneSignalId: ${ConfigUserInfo.userOneSignalId}');
  ConfigUserInfo.phone = _userInfo.phone;
  ConfigUserInfo.address = _userInfo.address;
  ConfigUserInfo.birthday = _userInfo.birthday;
  ConfigUserInfo.email = _userInfo.email;
  ConfigUserInfo.name = _userInfo.name;
  ConfigUserInfo.userOneSignalId =
      await ConfigApp.oneSignalService.getOneSignalId();
  print('QB\: OneSignalId: ${ConfigUserInfo.userOneSignalId}');
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

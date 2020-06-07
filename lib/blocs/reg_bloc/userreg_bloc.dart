import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/repository/user_repository.dart';
import 'package:findingmotels/validator/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'userreg_event.dart';
part 'userreg_state.dart';

class UserregBloc extends Bloc<UserregEvent, UserregState> {
  UserRepository userRepository;
  UserregBloc({this.userRepository});
  @override
  UserregState get initialState => UserregInitial();

  final String avatarImageUrl =
      "https://static.wixstatic.com/media/4dc520_da856960ddf14f5c8a49b4443b16f59b~mv2.jpg";

  @override
  Stream<UserregState> mapEventToState(
    UserregEvent event,
  ) async* {
    if (event is SignUpButtonPressed) {
      yield UserRegLoading();
      try {
        if (Valid.isUserNamee(event.userName)) {
          if (Valid.isEmail(event.email)) {
            if (Valid.isPassword(event.password)) {
              var user = await userRepository.signUpUserWithEmailPass(
                  event.email, event.password);
              if (user != null) {
                FirebaseUser userSend = await updateUser(event, user);
                ConfigApp.fbuser = user;
                ConfigApp.userRepository = userRepository;
                yield UserRegSuccessful(userSend, userRepository);
              } else {
                yield UserRegFailure(
                    message: "Login failed! please check again");
              }
            } else {
              yield UserRegFailure(
                  message: "Password must be greater than 8 characters");
            }
          } else {
            yield UserRegFailure(message: "Invalid Email! Please check again!");
          }
        } else {
          yield UserRegFailure(
              message: "UserName must be greater than 3 characters");
        }
      } catch (e) {
        yield UserRegFailure(message: e.toString());
      }
    } else if (event is HideShowPasswordEvent) {
      yield HideShowPasswordState(isHide: event.isHide);
    }
    yield UserregInitial();
  }

  Future<FirebaseUser> updateUser(
      SignUpButtonPressed event, FirebaseUser user) async {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = event.userName;
    updateInfo.photoUrl = avatarImageUrl;
    await user.updateProfile(updateInfo);
    await user.reload();
    var userSend = await userRepository.getCurrentUser();
    print('USERNAME IS: ${userSend.displayName}');
    return userSend;
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/repository/user_repository.dart';
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
        if (event.isCheckin) {
          if (event.userName != null && event.userName.length > 2) {
            if (event.email.contains("@") &&
                event.email.contains(".") &&
                event.email != null) {
              if (event.password != null && event.password.length > 5) {
                var user = await userRepository.signUpUserWithEmailPass(
                    event.email, event.password);
                if (user != null) {
                  UserUpdateInfo updateInfo = UserUpdateInfo();
                  updateInfo.displayName = event.userName;
                  updateInfo.photoUrl = avatarImageUrl;
                  await user.updateProfile(updateInfo);
                  await user.reload();
                  var userSend = await userRepository.getCurrentUser();
                  print('USERNAME IS: ${userSend.displayName}');
                  yield UserRegSuccessful(userSend, userRepository);
                } else {
                  yield UserRegFailure(
                      message: "Login failed! please check again");
                }
              } else {
                yield UserRegFailure(
                    message: "Password must be greater than 5 characters");
              }
            } else {
              yield UserRegFailure(
                  message: "Invalid Email! Please check again!");
            }
          } else {
            yield UserRegFailure(
                message: "UserName must be greater than 2 characters");
          }
        } else {
          yield UserRegFailure(
              message: "You have not agreed to the terms and privacy policy");
        }
      } catch (e) {
        yield UserRegFailure(message: e.toString());
      }
    } else if (event is HideShowPasswordEvent) {
      yield HideShowPasswordState(isHide: event.isHide);
    }
    yield UserregInitial();
  }
}

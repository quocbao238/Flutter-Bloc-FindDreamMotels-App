import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/models/user_fb_model.dart';
import 'package:findingmotels/repository/error_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oktoast/oktoast.dart';
import 'package:http/http.dart' as http;

class FirebaseAuthServices {
  FirebaseAuth firebaseAuth;
  FirebaseAuthServices() {
    this.firebaseAuth = FirebaseAuth.instance;
  }

  Future<FirebaseUser> loginWithFB() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),email&access_token=$token');
        // final profile = JSON.jsonDecode(graphResponse.body);
        var facebookUser = userFacebookModelFromJson(graphResponse.body);
        AuthCredential authCredential =
            FacebookAuthProvider.getCredential(accessToken: token);
        print(authCredential.toString());
        ConfigApp.fbuser =
            (await firebaseAuth.signInWithCredential(authCredential)).user;
        return await updateUserToFirebaseAuth(
            imgUrl: facebookUser.picture.data.url);
        break;
      case FacebookLoginStatus.cancelledByUser:
        return null;
        break;
      case FacebookLoginStatus.error:
        return null;
        break;
    }
    return ConfigApp.fbuser;
  }

  Future<FirebaseUser> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return null;
      AuthResult res = await firebaseAuth
          .signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      if (res.user != null) {
        ConfigApp.fbuser = await firebaseAuth.currentUser();
        return res.user;
      } else {
        return null;
      }
    } catch (e) {
      print(e.message);
      print("Error logging with google");
      return null;
    }
  }

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

  // sign up with email
  Future<FirebaseUser> signUpUserWithEmailPass(
      String email, String pass) async {
    try {
      var authResult = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      print("REPO : ${authResult.user.email}");
      return authResult.user;
    } on PlatformException catch (e) {
      showToast(e.message);
      String authError = "";
      switch (e.code) {
        case ErrorCodes.ERROR_C0DE_NETWORK_ERROR:
          authError = ErrorMessages.ERROR_C0DE_NETWORK_ERROR;
          break;
        case ErrorCodes.ERROR_USER_NOT_FOUND:
          authError = ErrorMessages.ERROR_USER_NOT_FOUND;
          break;
        case ErrorCodes.ERROR_TOO_MANY_REQUESTS:
          authError = ErrorMessages.ERROR_TOO_MANY_REQUESTS;
          break;
        case ErrorCodes.ERROR_INVALID_EMAIL:
          authError = ErrorMessages.ERROR_INVALID_EMAIL;
          break;
        case ErrorCodes.ERROR_CODE_USER_DISABLED:
          authError = ErrorMessages.ERROR_CODE_USER_DISABLED;
          break;
        case ErrorCodes.ERROR_CODE_WRONG_PASSWORD:
          authError = ErrorMessages.ERROR_CODE_WRONG_PASSWORD;
          break;
        case ErrorCodes.ERROR_CODE_EMAIL_ALREADY_IN_USE:
          authError = ErrorMessages.ERROR_CODE_EMAIL_ALREADY_IN_USE;
          break;
        case ErrorCodes.ERROR_OPERATION_NOT_ALLOWED:
          authError = ErrorMessages.ERROR_OPERATION_NOT_ALLOWED;
          break;
        case ErrorCodes.ERROR_CODE_WEAK_PASSWORD:
          authError = ErrorMessages.ERROR_CODE_WEAK_PASSWORD;
          break;
        default:
          authError = ErrorMessages.DEFAULT;
          break;
      }
      throw Exception(authError);
    }
  }

  // sign in with email and password
  Future<FirebaseUser> signInEmailAndPassword(
      String email, String password) async {
    try {
      var authresult = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authresult.user;
    } on PlatformException catch (e) {
      String authError = "";
      switch (e.code) {
        case ErrorCodes.ERROR_C0DE_NETWORK_ERROR:
          authError = ErrorMessages.ERROR_C0DE_NETWORK_ERROR;
          break;
        case ErrorCodes.ERROR_USER_NOT_FOUND:
          authError = ErrorMessages.ERROR_USER_NOT_FOUND;
          break;
        case ErrorCodes.ERROR_TOO_MANY_REQUESTS:
          authError = ErrorMessages.ERROR_TOO_MANY_REQUESTS;
          break;
        case ErrorCodes.ERROR_INVALID_EMAIL:
          authError = ErrorMessages.ERROR_INVALID_EMAIL;
          break;
        case ErrorCodes.ERROR_CODE_USER_DISABLED:
          authError = ErrorMessages.ERROR_CODE_USER_DISABLED;
          break;
        case ErrorCodes.ERROR_CODE_WRONG_PASSWORD:
          authError = ErrorMessages.ERROR_CODE_WRONG_PASSWORD;
          break;
        case ErrorCodes.ERROR_CODE_EMAIL_ALREADY_IN_USE:
          authError = ErrorMessages.ERROR_CODE_EMAIL_ALREADY_IN_USE;
          break;
        case ErrorCodes.ERROR_OPERATION_NOT_ALLOWED:
          authError = ErrorMessages.ERROR_OPERATION_NOT_ALLOWED;
          break;
        case ErrorCodes.ERROR_CODE_WEAK_PASSWORD:
          authError = ErrorMessages.ERROR_CODE_WEAK_PASSWORD;
          break;
        default:
          authError = ErrorMessages.DEFAULT;
          break;
      }
      throw Exception(authError);
    }
  }

  // sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // check signIn
  Future<bool> isSignedIn() async {
    var currentUser = await firebaseAuth.currentUser();
    return currentUser != null;
  }

  // get current user
  Future<FirebaseUser> getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser();
  }
}

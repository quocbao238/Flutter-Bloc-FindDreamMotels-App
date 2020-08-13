// import 'package:findingmotels/config_app/configApp.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as JSON;

// class FacebookService {
//   Future<void> loginWithFB() async {
//     final facebookLogin = FacebookLogin();
//     final result = await facebookLogin.logInWithReadPermissions(['email']);
//     switch (result.status) {
//       case FacebookLoginStatus.loggedIn:
//         final token = result.accessToken.token;
//         final graphResponse = await http.get(
//             'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
//         final profile = JSON.jsonDecode(graphResponse.body);
//         ConfigApp.fbuser = await FirebaseAuth.instance.signInWithFacebook(accessToken: result.accessToken.token);
//         print(profile);
//         break;
//       case FacebookLoginStatus.cancelledByUser:
//         break;
//       case FacebookLoginStatus.error:
//         break;
//     }
//   }
// }

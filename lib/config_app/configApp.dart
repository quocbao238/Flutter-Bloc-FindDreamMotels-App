import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ConfigApp {
  ConfigApp._();
  static FirebaseAuth authen;
  static FirebaseUser fbuser;
  static GoogleSignIn googleSignIn;
  static GoogleSignInAccount googleSignInAccount;
  static GoogleSignInAuthentication googleSignInAuthentication;
  static String accessToken = "";
  static String idToken = "";
  static String namedContact = "";
  static String userName = "";
}

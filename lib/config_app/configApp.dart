
import 'package:findingmotels/services/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ConfigApp {
  ConfigApp._();

  static bool drawerShow = false;
  static FirebaseAuthServices firebaseAuth = FirebaseAuthServices();
  static FirebaseUser fbuser;
  
  static FirebaseApp fbApp;
  static FirebaseAuth authen;
  // static GoogleSignIn googleSignIn;
  // static GoogleSignInAccount googleSignInAccount;
  // static GoogleSignInAuthentication googleSignInAuthentication;
  // static String accessToken = "";
  // static String idToken = "";
  // static String namedContact = "";
  // static String userName = "";
}

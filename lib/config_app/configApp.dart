import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findingmotels/services/cloud_storage_service.dart';
import 'package:findingmotels/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ConfigApp {
  ConfigApp._();

  static bool drawerShow = false;
  static FirebaseAuthServices firebaseAuth = FirebaseAuthServices();
  static CloudStorageService fbCloudStorage = CloudStorageService();
  static FirebaseApp fbApp;
  static FirebaseStorage fbStorage;
  static FirebaseUser fbuser;
  static final databaseReference = Firestore.instance;

  // static FirebaseAuth authen;
  // static GoogleSignIn googleSignIn;
  // static GoogleSignInAccount googleSignInAccount;
  // static GoogleSignInAuthentication googleSignInAuthentication;
  // static String accessToken = "";
  // static String idToken = "";
  // static String namedContact = "";
  // static String userName = "";
}

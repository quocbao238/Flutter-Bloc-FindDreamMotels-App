import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findingmotels/services/cloud_storage_service.dart';
import 'package:findingmotels/services/firebase_auth_service.dart';
import 'package:findingmotels/services/google_map_service.dart';
import 'package:findingmotels/services/onesignal_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ConfigApp {
  ConfigApp._();

  static bool drawerShow = false;
  static FirebaseAuthServices firebaseAuth = FirebaseAuthServices();
  static Location location = Location();
  static LocationData locationData;
  static PermissionStatus permissionStatus;
  static LatLng mylatLng;
  static Completer<GoogleMapController> ggCompleter = Completer();
  static GoogleMapController googleMapController;
  static CloudStorageService fbCloudStorage = CloudStorageService();
  static MyGoogleMapService myGoogleMapService = MyGoogleMapService();
  static FirebaseApp fbApp;
  static FirebaseStorage fbStorage;
  static FirebaseUser fbuser;
  static final databaseReference = Firestore.instance;
  static OneSignalService oneSignalService = OneSignalService();
}

class ConfigUserInfo {
  ConfigUserInfo._();
  static String name;
  static String phone;
  static String birthday;
  static String email;
  static String address;
  static String userOneSignalId;
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class RealTimeDB {
  RealTimeDB._();
  static FirebaseApp firebaseApp;
  static FirebaseDatabase firebaseDatabase;
  static DatabaseReference districtsReference;
}

void innitDB() {
  // RealTimeDB.firebaseApp = FirebaseApp.configure(name: null, options: null)
  // RealTimeDB.firebaseDatabase = FirebaseDatabase(app: RealTimeDB.firebaseApp);
  // RealTimeDB.districtsReference =
  //     RealTimeDB.firebaseDatabase.reference().child("Districts");
}

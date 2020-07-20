import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  // FirebaseService._();
  static Future setupFirebase() async {
    ConfigApp.fbApp = await FirebaseApp.configure(
      name: 'test',
      options: FirebaseOptions(
        googleAppID: AppSetting.googleAppID,
        gcmSenderID: AppSetting.gcmSenderID,
        apiKey: AppSetting.apiKey,
        projectID: AppSetting.projectID,
      ),
    );
    ConfigApp.fbStorage = FirebaseStorage(
        app: ConfigApp.fbApp,
        storageBucket: 'gs://find-accommodation-b2e61.appspot.com/');
  }

  

}

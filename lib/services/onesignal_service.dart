import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService {
  Future oneSignalInit() async {
    // Debug
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    await OneSignal.shared.init(AppSetting.oneSingalKey, iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: true
    });
    // Show notify
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.none);
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
  }

  notificationReceivedHandler(Function(OSNotification) callBack) {
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      print('QUOCBAOsetNotificationReceivedHandler');
      callBack(notification);
    });
  }

  notificationOpenedHandler(Function(OSNotificationOpenedResult) callBack) {
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('QUOCBAOsetNotificationOpenedHandler');
      callBack(result);
    });
  }

  Future<void> oneSingalListen() async {
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      print('QUOCBAOsetNotificationReceivedHandler');
    });

    OneSignal.shared.setInAppMessageClickedHandler(
        (OSInAppMessageAction action) =>
            print('QUOCBAOsetInAppMessageClickedHandler'));

    OneSignal.shared.setSubscriptionObserver(
        (OSSubscriptionStateChanges changes) =>
            print('QUOCBAOsetSubscriptionObserver'));

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) =>
        print('QUOCBAOsetPermissionObserver'));

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges changes) =>
            print('QUOCBAOfsetEmailSubscriptionObserver'));
  }

  Future<String> getOneSignalId() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    return status.subscriptionStatus.userId;
  }

  Future<bool> checkPermission() =>
      OneSignal.shared.promptUserForPushNotificationPermission();

  void sendNotifyToManagerHotel(MotelModel motelModel) async {
    var imgUrlString =
        "https://firebasestorage.googleapis.com/v0/b/find-accommodation-b2e61.appspot.com/o/imgApp%2F1595211649237?alt=media&token=c65fafd3-bc57-418b-98e6-d9f512e95e7e";
    var notification = OSCreateNotification(
      playerIds: ['d77ddac8-b4c9-4922-b00f-9e89a93880f5'],
      content: "Bùi Quốc Bảo booking your Hotel",
      heading: "Booking Senses Legend Hotel",
      iosAttachments: {"id1": imgUrlString},
      bigPicture: imgUrlString,
      androidSmallIcon:
          'https://www.filepicker.io/api/file/1Cp0BzAKRMer436RhHtC',
      androidLargeIcon:
          'https://www.filepicker.io/api/file/pv2yRkLTOObLs2rSYFci',
      // androidChannelId:
      //     'https://www.filepicker.io/api/file/pv2yRkLTOObLs2rSYFci'
      // buttons: [
      //   OSActionButton(text: "test1", id: "id1"),
      //   OSActionButton(text: "test2", id: "id2")
      // ]
    );

    var response = await OneSignal.shared.postNotification(notification);
  }
}

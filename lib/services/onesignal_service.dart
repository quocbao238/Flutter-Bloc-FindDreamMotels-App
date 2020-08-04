
import 'package:findingmotels/config_app/setting.dart';
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

  Future<bool> checkPermission() =>
      OneSignal.shared.promptUserForPushNotificationPermission();

  // Future<String> getOneSignalId() async {
  //   var status = await OneSignal.shared.getPermissionSubscriptionState();
  //   if (status.subscriptionStatus.userId != ConfigApp.fbuser.uid) {
  //     await OneSignal.shared.setExternalUserId('5BMDfV3RzwdwBqWSHSfrXpFkUPn1');
  //   }
  //   var newStatus = await OneSignal.shared.getPermissionSubscriptionState();
  //   print('Debugggggg\: OneSignalId: ${newStatus.subscriptionStatus.userId}');
  //   return newStatus.subscriptionStatus.userId;
  // }

  Future<bool> setOneSignalId(String uId) async {
    var data = await OneSignal.shared.setExternalUserId(uId);
    return data != null ? true : false;
  }
}

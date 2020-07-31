import 'package:findingmotels/config_app/configApp.dart';
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

  Future<bool> checkPermission() =>
      OneSignal.shared.promptUserForPushNotificationPermission();

  Future<String> getOneSignalId() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    if (status.subscriptionStatus.userId != ConfigApp.fbuser.uid) {
      // await OneSignal.shared.setExternalUserId(ConfigApp.fbuser.uid);

      await OneSignal.shared.setExternalUserId('5BMDfV3RzwdwBqWSHSfrXpFkUPn1');
    }
    var newStatus = await OneSignal.shared.getPermissionSubscriptionState();
    print('Debugggggg\: OneSignalId: ${newStatus.subscriptionStatus.userId}');
    return newStatus.subscriptionStatus.userId;
  }

  void sendNotifyToManagerHotel(MotelModel motelModel) async {
    OSCreateNotification notification = OSCreateNotification(
        playerIds: ['5BMDfV3RzwdwBqWSHSfrXpFkUPn1'],
        content: "Bao booking your Hotel",
        heading: "Heading title asd}",
        androidSmallIcon: AppSetting.oneSignalIcon,
        androidLargeIcon: AppSetting.oneSignalIcon);
    await OneSignal.shared.postNotification(notification);
  }

  // void sendNotifyToManagerHotel(MotelModel motelModel) async {
  //   OSCreateNotification notification = OSCreateNotification(
  //       playerIds: ['5BMDfV3RzwdwBqWSHSfrXpFkUPn1'],
  //       // playerIds: ['${motelModel.oneSignalId}'],
  //       content: "${ConfigUserInfo.name} booking your Hotel",
  //       heading: "${motelModel.title}",
  //       // iosAttachments: {"id1": motelModel.imageMotel[0].imageUrl},
  //       // subtitle: : motelModel.imageMotel[0].imageUrl,
  //       androidSmallIcon: AppSetting.oneSignalIcon,
  //       androidLargeIcon: AppSetting.oneSignalIcon);
  //   await OneSignal.shared.postNotification(notification);
  // }
}

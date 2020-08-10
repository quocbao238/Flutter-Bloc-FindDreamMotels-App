import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:findingmotels/models/oneSignalModel.dart';
import 'package:http/http.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:http/http.dart' as http;

class OneSignalService {
  Future oneSignalInit() async {
    // Debug
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    await OneSignal.shared.init(AppSetting.oneSingalAppId, iOSSettings: {
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

  Future<bool> setOneSignalId(String uId) async {
    var data = await OneSignal.shared.setExternalUserId(uId);
    return data != null ? true : false;
  }

  Future<bool> sendNotifyToManagerHotel(MotelModel motelModel) async {
    var notification = OneSignalSendReq(
        appId: AppSetting.oneSingalAppId,
        headings:
            Contents(en: "${ConfigUserInfo?.name ?? ""} booking your Hotel"),
        contents:
            Contents(en: "Deluxe Double Room\nFrom 08/08/2020 to 10/08/2020"),
        subtitle:
            Contents(en: "Deluxe Double Room\nFrom 08/08/2020 to 10/08/2020"),
        includeExternalUserIds: [motelModel.userIdCreate],
        iosAttachments: IosAttachments(id1: AppSetting.oneSignalImage),
        largeIcon: AppSetting.oneSignalImage,
        smallIcon: AppSetting.oneSignalImage);
    try {
      // var client = http.Client();
      Response response = await http.post(AppSetting.oneSingalSendApi,
          headers: {
            "Authorization": "Basic ${AppSetting.oneSingalResApiKey}",
            "Content-Type": "application/json"
          },
          body: oneSignalSendReqToJson(notification));
      print(oneSignalSendReqToJson(notification));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Catch OneSingalService  $e");
      return false;
    }
  }

  // void sendNotifyToManagerHotel(MotelModel motelModel) async {
  //   OSCreateNotification notification = OSCreateNotification(
  //       playerIds: ["5BMDfV3RzwdwBqWSHSfrXpFkUPn1"],
  //       content: "Quoc Bao booking your Hotel",
  //       heading: "DemosendData",
  //       iosAttachments: {"id1": ""},
  //       subtitle: "",
  //       androidSmallIcon: AppSetting.oneSignalIcon,
  //       androidLargeIcon: AppSetting.oneSignalIcon);
  // await OneSignal.shared.postNotification(notification);
  // }
  // }
}

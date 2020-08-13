import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/history_model.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:findingmotels/models/rate_model.dart';
import 'package:findingmotels/models/userInfo_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CloudStorageResult {
  final String imageUrl;
  CloudStorageResult({this.imageUrl});
}

class CloudStorageService {
  Future<String> updateAvatar({String uuid}) async {
    var imageFileName = uuid;
    File imageToUpload = await selectImage();
    if (imageToUpload != null) {
      try {
        final StorageReference firebaseStorageRef =
            ConfigApp.fbStorage.ref().child('userAvatar').child(imageFileName);
        StorageUploadTask uploadTask =
            firebaseStorageRef.putFile(imageToUpload);
        StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;
        var downloadUrl = await storageSnapshot.ref.getDownloadURL();
        if (uploadTask.isComplete) {
          return downloadUrl;
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      return null;
    }

    return null;
  }

  Future<CloudStorageResult> updatetoClound({
    String title,
  }) async {
    var imageFileName =
        title + DateTime.now().millisecondsSinceEpoch.toString();
    File imageToUpload = await selectImage();
    if (imageToUpload != null) {
      try {
        final StorageReference firebaseStorageRef =
            ConfigApp.fbStorage.ref().child(imageFileName);
        StorageUploadTask uploadTask =
            firebaseStorageRef.putFile(imageToUpload);
        StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;
        var downloadUrl = await storageSnapshot.ref.getDownloadURL();
        if (uploadTask.isComplete) {
          return CloudStorageResult(imageUrl: downloadUrl.toString());
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      return null;
    }

    return null;
  }

  Future<File> selectImage() async {
    return await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
  }

  Future<String> readImage({String title}) async {
    try {
      String url =
          await ConfigApp.fbStorage.ref().child(title).getDownloadURL();
      return url;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<UserInfoModel> featchUserData({String userName = ""}) async {
    UserInfoModel _userInfo = UserInfoModel();
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection('info')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        if (f.documentID == ConfigApp.fbuser.uid)
          _userInfo = UserInfoModel.fromJson(f.data);
      });
    });
    if (_userInfo.name == null || _userInfo.name == "")
      _userInfo = await createUserData(userName: userName);
    ConfigUserInfo.phone = _userInfo.phone;
    ConfigUserInfo.address = _userInfo.address;
    ConfigUserInfo.birthday = _userInfo.birthday;
    ConfigUserInfo.email = _userInfo.email;
    ConfigUserInfo.name = _userInfo.name;
    ConfigUserInfo.roleId = _userInfo.role;
    ConfigApp.oneSignalService.setOneSignalId(ConfigApp.fbuser.uid);
    print('QB\: OneSignalId: ${ConfigApp.fbuser.uid}');
    return _userInfo;
  }

  Future<UserInfoModel> createUserData({String userName}) async {
    UserInfoModel _userInfo = UserInfoModel(
        name: userName == "" ? ConfigApp.fbuser.displayName : userName,
        photoUrl: ConfigApp.fbuser.photoUrl,
        email: ConfigApp.fbuser.email,
        address: ' ',
        birthday: ' ',
        phone: ' ',
        role: '0');
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection('info')
        .document(ConfigApp.fbuser.uid)
        .setData(_userInfo.toJson());
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection('info')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        if (f.documentID == ConfigApp.fbuser.uid)
          _userInfo = UserInfoModel.fromJson(f.data);
      });
    });
    print("Run serviceCloudStorageService.createUserData");
    return _userInfo;
  }

  Future<UserInfoModel> setDataToClound(UserInfoModel _userInfo) async {
    UserInfoModel userInfoModel = UserInfoModel();
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection('info')
        .document(ConfigApp.fbuser.uid)
        .setData(_userInfo.toJson());
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection('info')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        if (f.documentID == ConfigApp.fbuser.uid)
          userInfoModel = UserInfoModel.fromJson(f.data);
      });
    });
    return userInfoModel;
  }

  Future<RateModel> checkRatingHotels(HistoryModel historyModel) async {
    RateModel rateModel;
    await ConfigApp.databaseReference
        .collection(AppSetting.dbData)
        .document(AppSetting.locationHCM)
        .collection(historyModel.motelBooking.districtId.toString())
        .document(historyModel.motelBooking.documentId)
        .collection(AppSetting.userComment)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        if (f.documentID == historyModel.motelBooking.documentId) {
          rateModel = RateModel.fromJson(f.data);
        }
      });
    });
    return rateModel;
  }

  Future<double> getStartRatingHotels(HistoryModel historyModel) async {
    double ratingApp = 0.0;
    await ConfigApp.databaseReference
        .collection(AppSetting.dbData)
        .document(AppSetting.locationHCM)
        .collection(historyModel.motelBooking.districtId.toString())
        .document(historyModel.motelBooking.documentId)
        .collection(AppSetting.userComment)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        if (f.documentID == historyModel.motelBooking.documentId) {
          ratingApp = f.data['rating'].toDouble();
        }
      });
    });
    return ratingApp;
  }

  Future<bool> setRatingHotels(HistoryModel historyModel, double rating) async {
    bool isSucess = false;
    RateModel rateModel = RateModel(
        userId: ConfigApp.fbuser.uid,
        comment: "",
        rating: rating,
        avatar: ConfigApp.fbuser.photoUrl,
        userName: ConfigUserInfo.name);
    await ConfigApp.databaseReference
        .collection(AppSetting.dbData)
        .document(AppSetting.locationHCM)
        .collection(historyModel.motelBooking.districtId.toString())
        .document(historyModel.motelBooking.documentId)
        .collection(AppSetting.userComment)
        .document(historyModel.motelBooking.documentId)
        .setData(rateModel.toJson())
        .then((value) => isSucess = true);
    return isSucess;
  }

  Future<bool> writeCommentRatingHotels(
      HistoryModel historyModel, String comment) async {
    bool sucess = false;
    await ConfigApp.databaseReference
        .collection(AppSetting.dbData)
        .document(AppSetting.locationHCM)
        .collection(historyModel.motelBooking.districtId.toString())
        .document(historyModel.motelBooking.documentId)
        .collection(AppSetting.userComment)
        .document(historyModel.motelBooking.documentId)
        .updateData({'comment': comment}).then((value) => sucess = true);
    return sucess;
  }

  Future<bool> updateHistoryToClound(
      MotelModel motel, DetailBooking detailBooking) async {
    //type 0 -> History
    //type 1 -> Booking
    String _timeNow = DateTime.now().millisecondsSinceEpoch.toString();
    HistoryModel _historyModelBooking = HistoryModel(
        timeBooking: _timeNow,
        type: 1,
        detailBooking: detailBooking,
        userBookingId: ConfigApp.fbuser.uid,
        userBookingName: ConfigUserInfo.name,
        motelBooking: motel);

    HistoryModel _historyModelHistory = HistoryModel(
        timeBooking: _timeNow,
        type: 0,
        detailBooking: detailBooking,
        userBookingId: ConfigApp.fbuser.uid,
        userBookingName: ConfigUserInfo.name,
        motelBooking: motel);

    //Booking
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(motel.userIdCreate)
        .collection('history')
        .document(_timeNow)
        .setData(_historyModelBooking.toJson());

    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection('history')
        .document(_timeNow)
        .setData(_historyModelHistory.toJson());
    return true;
  }

  Future<List<HistoryModel>> getListHistory() async {
    List<HistoryModel> _listHistory = [];
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection('history')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        var _history = HistoryModel.fromJson(f.data);
        _listHistory.add(_history);
      });
    });
    return _listHistory;
  }

  Future<List<RateModel>> getListRating(MotelModel motelModel) async {
    List<RateModel> listRateModel = [];
    await ConfigApp.databaseReference
        .collection(AppSetting.dbData)
        .document(AppSetting.locationHCM)
        .collection(motelModel.districtId.toString())
        .document(motelModel.documentId)
        .collection(AppSetting.userComment)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        var rateModel = RateModel.fromJson(f.data);
        listRateModel.add(rateModel);
      });
    });
    return listRateModel;
  }
}

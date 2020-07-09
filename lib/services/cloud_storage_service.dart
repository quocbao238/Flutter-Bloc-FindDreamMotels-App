import 'dart:io';
import 'package:findingmotels/config_app/configApp.dart';
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
        source: ImageSource.gallery,
        maxHeight: 200,
        maxWidth: 200);
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
}

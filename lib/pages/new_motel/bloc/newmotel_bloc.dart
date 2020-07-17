import 'dart:async';
import 'package:basic_utils/basic_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:findingmotels/validator/validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:findingmotels/config_app/sizeScreen.dart' as app;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:oktoast/oktoast.dart';
part 'newmotel_state.dart';
part 'newmotel_event.dart';

List<String> districList = [
  "District 1",
  "District 2",
  "District 3",
  "District 4",
  "District 5",
  "District 6",
  "District 7",
  "District 8",
  "District 9",
  "District 10",
  "District 11",
  "District 12",
  "Binh Tan District",
  "Binh Thanh District",
  "Go Vap District",
  "Phu Nhuan District",
  "Tan Binh District",
  "Tan Phu District",
  "Thu Duc District",
  "Binh Chanh District",
  "Can Gio District",
  "Cu Chi District",
  "Hoc Mon District",
  "Nha Be District"
];

List<String> listAmenitiesStr = [
  "freeWifi",
  "bed",
  "airCondition",
  "bathRoom",
  "televison",
];

class NewmotelBloc extends Bloc<NewmotelEvent, NewmotelState> {
  @override
  NewmotelState get initialState => NewmotelInitial();

  @override
  Stream<NewmotelState> mapEventToState(
    NewmotelEvent event,
  ) async* {
    if (event is OnTapSelectDistrictEvent) {
      String district = await getDistrictSelect(
          context: event.context, district: event.district);
      yield district != ''
          ? OnTapSelectDistrictSucessState(district)
          : OnTapSelectDistrictFailState();
    } else if (event is OnTapSelectAmenitiesEvent) {
      List<Amenity> lstamenities = await getAmenitiesSelect(
          lstamenities: event.listAmenity, context: event.context);
      yield lstamenities != null
          ? OnTapSelectAmenitiesSucessState(lstamenities)
          : OnTapSelectAmenitiesFailState();
    } else if (event is OnTapSelectImgEvent) {
      var lstImg = await getMultiImageFromLocal(event.image);
      yield lstImg.length > 0
          ? OnTapSelectImgSucessState(lstImg)
          : OnTapSelectImgFailState();
    } else if (event is OnTapCreateEvent) {
      yield LoadingState();
      if (Valid.checkNull(event.title)) {
        if (Valid.checkNull(event.description)) {
          if (Valid.checkNull(event.address)) {
            if (event.districtId != null) {
              if (event.amenities != null) {
                if (event.price != null) {
                  if (event.listImg != null) {
                    List<ImageMotel> lstImg =
                        await updateImgToClound(event.listImg);
                    if (lstImg != null) {
                      var motel = await createNewPost(
                          title: event.title,
                          description: event.description,
                          address: event.address,
                          districtId: event.districtId,
                          amenities: event.amenities,
                          price: event.price,
                          imageMotel: lstImg,
                          location: event.location,
                          email: ConfigUserInfo.email ?? "",
                          name: ConfigUserInfo.name,
                          phoneNumber: ConfigUserInfo.phone,
                          rating: 5.0,
                          timeUpdate:
                              DateTime.now().millisecondsSinceEpoch.toDouble(),
                          userIdCreate: ConfigApp.fbuser.uid);
                      if (motel != null) {
                        showToast('Create new post Sucess');
                        yield OnTapCreatePostSucessState();
                      } else {
                        yield OnTapCreatePostFailState(
                            errorMessage:
                                'Create new post fail, Please try again later');
                      }
                    } else {
                      yield OnTapCreatePostFailState(
                          errorMessage:
                              'An Image error occurred please try again later');
                    }
                  } else {
                    yield OnTapCreatePostFailState(
                        errorMessage: 'Please select an Image');
                  }
                } else {
                  yield OnTapCreatePostFailState(
                      errorMessage: 'Price can not Empty');
                }
              } else {
                yield OnTapCreatePostFailState(
                    errorMessage: 'Please Select Amenities');
              }
            } else {
              yield OnTapCreatePostFailState(
                  errorMessage: 'Please Select District');
            }
          } else {
            yield OnTapCreatePostFailState(
                errorMessage: 'Address can not Empty');
          }
        } else {
          yield OnTapCreatePostFailState(
              errorMessage: 'Description can not Empty');
        }
      } else {
        yield OnTapCreatePostFailState(errorMessage: 'Title can not Empty');
      }
    }
    yield NewmotelInitial();
  }
}

Future<MotelModel> createNewPost(
    {String userIdCreate,
    int districtId,
    String title,
    String name,
    String email,
    double timeUpdate,
    String address,
    double rating,
    String price,
    String phoneNumber,
    List<ImageMotel> imageMotel,
    List<Amenity> amenities,
    String description,
    Location location}) async {
  int newDocument = DateTime.now().millisecondsSinceEpoch;
  MotelModel _newmotel = MotelModel(
      address: address,
      amenities: amenities,
      description: description,
      districtId: districtId,
      email: email,
      imageMotel: imageMotel,
      location: location,
      name: name,
      phoneNumber: phoneNumber,
      price: price,
      rating: rating,
      timeUpdate: timeUpdate,
      title: title,
      userIdCreate: userIdCreate);
  await ConfigApp.databaseReference
      .collection(districtId.toString())
      .document(newDocument.toString())
      .setData(_newmotel.toJson());
  await ConfigApp.databaseReference
      .collection(districtId.toString())
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) {
      if (f.documentID == newDocument.toString())
        _newmotel = MotelModel.fromJson(f.data);
    });
  });
  return _newmotel;
}

Future<ImageMotel> postImage(Asset imageFile) async {
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  StorageReference reference =
      ConfigApp.fbStorage.ref().child('imgApp').child(fileName);
  StorageUploadTask uploadTask =
      reference.putData((await imageFile.getByteData()).buffer.asUint8List());
  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
  var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
  if (uploadTask.isComplete) {
    print(downloadUrl);
    return ImageMotel(imageUrl: downloadUrl, name: imageFile.name);
  } else {
    return null;
  }
}

Future<List<ImageMotel>> updateImgToClound(List<Asset> lstimages) async {
  List<ImageMotel> lstMotel = [];
  await Future.wait(lstimages.map((v) async {
    var img = await postImage(v);
    if (img != null) {
      lstMotel.add(img);
    }
  }));
  return lstMotel;
}

Future<List<Asset>> getMultiImageFromLocal(List<Asset> images) async {
  List<Asset> resultList = List<Asset>();

  String error = 'No Error Dectected';
  try {
    resultList = await MultiImagePicker.pickImages(
      maxImages: 10,
      enableCamera: true,
      selectedAssets: images ?? List<Asset>(),
      cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      materialOptions: MaterialOptions(
        actionBarColor: "#095C71",
        actionBarTitle: "Select Image",
        allViewTitle: "All Photos",
        useDetailsView: false,
        selectCircleStrokeColor: "#000000",
      ),
    );
  } on Exception catch (e) {
    error = e.toString();
    print(error);
  }
  return resultList;
}

Future<List<Amenity>> getAmenitiesSelect(
    {BuildContext context, List<Amenity> lstamenities}) async {
  List<Amenity> _lstamenities = [];
  if (lstamenities == null) {
    listAmenitiesStr.forEach((element) {
      _lstamenities.add(Amenity(name: element, isHave: false));
    });
  } else {
    _lstamenities = lstamenities;
  }
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: app.Size.getWidth * 0.9,
              height: Size.getHeight * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColor.colorClipPath),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: 16.0, bottom: 16.0, right: 8, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop(_lstamenities);
                            },
                            icon: Icon(
                              Icons.cancel,
                              size: 30.0,
                              color: Colors.white,
                            )),
                        Text(
                          'Select Amenities',
                          style: StyleText.header24BWhitew400,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(_lstamenities);
                            })
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: _lstamenities.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 2.5,
                        ),
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                setState(() {
                                  _lstamenities[index].isHave =
                                      !_lstamenities[index].isHave;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: _lstamenities[index].isHave
                                        ? Colors.red[200]
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      StringUtils.capitalize(
                                          _lstamenities[index].name),
                                      style: _lstamenities[index].isHave
                                          ? StyleText.subhead16White500
                                          : StyleText.subhead16GreenMixBlue,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
                  SizedBox(height: 10.0)
                ],
              ),
            ),
          );
        });
      });
}

Future<String> getDistrictSelect(
    {BuildContext context, String district}) async {
  String _district = district != null ? district : districList[0];
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: app.Size.getWidth * 0.9,
              // height: Size.getHeight * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColor.colorClipPath),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: 16.0, bottom: 16.0, right: 8, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop('');
                            },
                            icon: Icon(
                              Icons.cancel,
                              size: 30.0,
                              color: Colors.white,
                            )),
                        Text(
                          'Select District',
                          style: StyleText.header24BWhitew400,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(_district);
                            })
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: districList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 2.5,
                        ),
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                setState(() {
                                  _district = districList[index];
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: _district == districList[index]
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      districList[index],
                                      style: _district == districList[index]
                                          ? StyleText.subhead16White500
                                          : StyleText.subhead16GreenMixBlue,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
                  SizedBox(height: 10.0)
                ],
              ),
            ),
          );
        });
      });
}

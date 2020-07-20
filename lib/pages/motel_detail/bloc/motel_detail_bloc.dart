import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:oktoast/oktoast.dart';

part 'motel_detail_event.dart';
part 'motel_detail_state.dart';

class MotelDetailBloc extends Bloc<MotelDetailEvent, MotelDetailState> {
  @override
  MotelDetailState get initialState => MotelDetailInitial();

  @override
  Stream<MotelDetailState> mapEventToState(
    MotelDetailEvent event,
  ) async* {
    if (event is FeatchDataEvent) {
      yield LoadingState();
      var listMotelFv = await featchListFavorite();
      if (listMotelFv.length > 0) {
        bool isfv = await checkFavorite(listMotelFv, event.motelModel);
        yield FeatchDataSucessState(isfv);
      } else {
        yield FeatchDataSucessState(false);
      }
    } else if (event is OnTapFavoriteEvent) {
      yield LoadingState();
      if (event.isFavorite) {
        //Delete
        showToast('Delete');
      } else {
        //Add New
        bool isFv = await addToListFavorite(event.motel);

        yield OnTapFavoriteSucessState(isFv);
      }
    }
    yield MotelDetailInitial();
  }
}

Future<bool> checkFavorite(
    List<MotelModel> favoriteList, MotelModel motelModel) async {
  var isFv = false;
  favoriteList.forEach((e) {
    if (e.name == motelModel.name) isFv = true;
  });
  return isFv;
}

// Future<bool> demoAddFavorite(MotelModel motelModel) async {
//   bool isHave = false;
//   try {
//     await ConfigApp.databaseReference
//         .collection(AppSetting.dbData)
//         .document(AppSetting.locationHCM)
//         .collection(AppSetting.dbpopular)
//         .document(motelModel.documentId)
//         .setData(motelModel.toJson());
//     await ConfigApp.databaseReference
//         .collection(AppSetting.dbData)
//         .document(AppSetting.locationHCM)
//         .collection(AppSetting.dbpopular)
//         .getDocuments()
//         .then((QuerySnapshot snapshot) {
//       snapshot.documents.forEach((f) {
//         isHave = f.documentID == motelModel.documentId ? true : false;
//       });
//     });
//   } catch (e) {
//     print(e.toString());
//     return false;
//   }
//   return isHave;
// }

Future<bool> addToListFavorite(MotelModel motelModel) async {
  bool isHave = false;
  try {
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection(AppSetting.dbfavorite)
        .document(motelModel.documentId)
        .setData(motelModel.toJson());
    await ConfigApp.databaseReference
        .collection(AppSetting.dbuser)
        .document(ConfigApp.fbuser.uid)
        .collection(AppSetting.dbfavorite)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        isHave = f.documentID == motelModel.documentId ? true : false;
      });
    });
  } catch (e) {
    print(e.toString());
    return false;
  }
  return isHave;
}

Future<List<MotelModel>> featchListFavorite() async {
  List<MotelModel> listMotel = [];
  await ConfigApp.databaseReference
      .collection(AppSetting.dbuser)
      .document(ConfigApp.fbuser.uid)
      .collection(AppSetting.dbfavorite)
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) {
      var motel = MotelModel.fromJson(f.data);
      listMotel.add(motel);
    });
  });
  listMotel.sort((a, b) => double.parse(a.timeUpdate.toString())
      .compareTo(double.parse(b.timeUpdate.toString())));
  return listMotel;
}

String getIconFromListAmenities(String name) {
  return name == "freeWifi"
      ? AppSetting.wifiIcon
      : name == "bed"
          ? AppSetting.bedIcon
          : name == "airCondition"
              ? AppSetting.airIcon
              : name == "bathRoom"
                  ? AppSetting.bathIcon
                  : name == "televison" ? AppSetting.tvIcon : "";
}

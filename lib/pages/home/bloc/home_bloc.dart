import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/models/district_model.dart';
import 'package:findingmotels/models/motel_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FeatchDataEvent) {
      yield LoadingState();
      var listMotel = await featchMotelPopular();
      if (listMotel != null) {
        yield FeatchDataSucesesState(listMotel: listMotel);
      } else {
        yield FeatchDataFailState();
      }
    } else if (event is OnClickListDistrictsEvent) {
      yield LoadingMotels();
      var listMotel =
          await featchMotelList(int.parse(event.districtModel.districtId));
      yield listMotel != null
          ? OnClickListDistrictsState(
              selectMotel: event.districtModel, listMotel: listMotel)
          : OnClickListDistrictsState(
              selectMotel: event.districtModel, listMotel: []);
    } else if (event is OnClickListMotelssEvent) {
      yield OnClickListMotelssState(event.motelModel);
    } else if (event is NewMotelEvent) {
      yield NewMotelState();
    }
    yield HomeInitial();
  }
}

Future<List<MotelModel>> featchMotelPopular() async {
  List<MotelModel> listMotel = [];
  await ConfigApp.databaseReference
      .collection('popular')
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

Future<List<MotelModel>> featchMotelList(int id) async {
  List<MotelModel> listMotel = [];
  await ConfigApp.databaseReference
      .collection(id.toString())
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

// Future<List<DistrictModel>> featchDistrictLst() async {
//   List<DistrictModel> listDistrict = [];
//   await ConfigApp.databaseReference
//       .collection(AppSetting.dbdistricList)
//       .getDocuments()
//       .then((QuerySnapshot snapshot) {
//     snapshot.documents.forEach((f) {
//       var district = DistrictModel.fromJson(f.data);
//       listDistrict.add(district);
//     });
//   });
//   listDistrict.sort(
//       (a, b) => int.parse(a.districtId).compareTo(int.parse(b.districtId)));
//   return listDistrict;
// }

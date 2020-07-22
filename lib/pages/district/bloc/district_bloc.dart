import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/district_model.dart';

part 'district_event.dart';
part 'district_state.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  DistrictState get initialState => DistrictInitial();

  @override
  Stream<DistrictState> mapEventToState(
    DistrictEvent event,
  ) async* {
    if (event is FeatchDistrictEvent) {
      yield LoadingDistrictState();
      var listDistrict = await featchDistrictLst();
      yield listDistrict != null
          ? FeatchDistrictSucessState(listDistrict)
          : DistrictErrorState(errorMessage);
    }
  }

  Future<List<DistrictModel>> featchDistrictLst() async {
    List<DistrictModel> listDistrict = [];
    await ConfigApp.databaseReference
        .collection(AppSetting.dbData)
        .document(AppSetting.locationHCM)
        .collection(AppSetting.dbdistricList)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        listDistrict.add(DistrictModel.fromJson(f.data));
      });
    });
    listDistrict.sort(
        (a, b) => int.parse(a.districtId).compareTo(int.parse(b.districtId)));
    return listDistrict;
  }
}

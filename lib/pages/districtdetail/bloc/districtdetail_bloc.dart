import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/motel_model.dart';

part 'districtdetail_event.dart';
part 'districtdetail_state.dart';

class DistrictdetailBloc
    extends Bloc<DistrictdetailEvent, DistrictdetailState> {
  DistrictdetailState get initialState => DistrictdetailInitial();

  @override
  Stream<DistrictdetailState> mapEventToState(
    DistrictdetailEvent event,
  ) async* {
    if (event is FeatchMotelDistrict) {
      yield LoadingDistrictDetail();
      var list = await featchMotelList(event.id);
      yield list != null
          ? FeatchDistrictMotelSucessState(list)
          : DistrictdetailError();
    } else if (event is GoToDetailEvent) {
      yield GoToDetailState(event.model);
    } else if (event is OnTapDirectionEvent) {
      yield OnTapDirectionState(event.model);
    }
    yield DistrictdetailInitial();
  }

  Future<List<MotelModel>> featchMotelList(String id) async {
    List<MotelModel> listMotel = [];
    await ConfigApp.databaseReference
        .collection(AppSetting.dbData) // data
        .document(AppSetting.locationHCM) //hcm
        .collection(id) //District1
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
}

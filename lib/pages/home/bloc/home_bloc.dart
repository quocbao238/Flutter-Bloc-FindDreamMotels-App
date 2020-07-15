import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/district_model.dart';

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
      var listDistrict = await featchDistrictLst();
      if(listDistrict!=null){
        yield FeatchDataSucesesState(listDistrict: listDistrict);
      }else {
        yield FeatchDataFailState();
      }
    } else if (event is OnClickListDistrictsEvent) {
      yield OnClickListDistrictsState(event.index);
    } else if (event is OnClickListMotelssEvent) {
      yield OnClickListMotelssState(event.index);
    }
    yield HomeInitial();
  }
}

Future<List<DistrictModel>> featchDistrictLst() async {
  List<DistrictModel> listDistrict = [];
  await ConfigApp.databaseReference
      .collection(AppSetting.collection)
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) {
      var district = DistrictModel.fromJson(f.data);
      listDistrict.add(district);
    });
  });
  return listDistrict;
}

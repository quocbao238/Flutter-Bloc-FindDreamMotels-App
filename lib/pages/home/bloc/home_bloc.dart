import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
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
    } else if (event is OnClickListMotelssEvent) {
      yield OnClickListMotelssState(event.motelModel);
    } else if (event is NewMotelEvent) {
      yield NewMotelState();
    } else if (event is OnTapHotelsEvent) {
      yield OnTapHotelsState();
    }
    yield HomeInitial();
  }
}

Future<List<MotelModel>> featchMotelPopular() async {
  List<MotelModel> listMotel = [];
  await ConfigApp.databaseReference
      .collection(AppSetting.dbData)
      .document(AppSetting.locationHCM)
      .collection(AppSetting.dbpopular)
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

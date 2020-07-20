import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/motel_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  @override
  FavoriteState get initialState => FavoriteInitial();

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is FeatchFavoriteListEvent) {
      yield FavoriteLoadingState();
      var data = await featchMotelFavorite();
      yield data.length > 0
          ? FeatchFavoriteListSucessState(data)
          : OnFailState('An error occurred, please try again later');
    } else if (event is GoToDetailEvent) {
      yield GoToDetailState(event.motelModel);
    }
    yield FavoriteInitial();
  }

  Future<List<MotelModel>> featchMotelFavorite() async {
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
}

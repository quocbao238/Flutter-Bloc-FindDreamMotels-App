import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/models/history_model.dart';

part 'notify_event.dart';
part 'notify_state.dart';

class NotifyBloc extends Bloc<NotifyEvent, NotifyState> {
  @override
  NotifyState get initialState => NotifyInitial();

  @override
  Stream<NotifyState> mapEventToState(
    NotifyEvent event,
  ) async* {
    if (event is FeatchListHistoryEvent) {
      yield LoadingState();
      var listHistory = await ConfigApp.fbCloudStorage.getListHistory();
      if (listHistory.length > 0) {
        yield FeatchListHistorySucessState(listHistory);
      } else {
        yield NotifyInitial();
      }
    }
  }
}

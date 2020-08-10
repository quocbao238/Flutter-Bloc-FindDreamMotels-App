import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'historydetail_event.dart';
part 'historydetail_state.dart';

class HistorydetailBloc extends Bloc<HistorydetailEvent, HistorydetailState> {
  HistorydetailState get initialState => HistorydetailInitial();

  @override
  Stream<HistorydetailState> mapEventToState(
    HistorydetailEvent event,
  ) async* {}
}

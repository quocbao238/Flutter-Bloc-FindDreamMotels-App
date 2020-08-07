part of 'notify_bloc.dart';

abstract class NotifyState extends Equatable {
  const NotifyState();
  @override
  List<Object> get props => [];
}

class NotifyInitial extends NotifyState {}

class LoadingState extends NotifyState{}
class FeatchListHistorySucessState extends NotifyState {
  final List<HistoryModel> listHistory;
  FeatchListHistorySucessState(this.listHistory);
}

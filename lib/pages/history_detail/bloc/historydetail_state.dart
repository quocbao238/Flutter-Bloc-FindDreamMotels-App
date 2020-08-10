part of 'historydetail_bloc.dart';

abstract class HistorydetailState extends Equatable {
  const HistorydetailState();
  @override
  List<Object> get props => [];
}

class HistorydetailInitial extends HistorydetailState {}

class LoadingState extends HistorydetailState{}

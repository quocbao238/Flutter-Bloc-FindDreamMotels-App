part of 'notify_bloc.dart';

abstract class NotifyEvent extends Equatable {
  const NotifyEvent();
  @override
  List<Object> get props => [];
}

class FeatchListHistoryEvent extends NotifyEvent {}


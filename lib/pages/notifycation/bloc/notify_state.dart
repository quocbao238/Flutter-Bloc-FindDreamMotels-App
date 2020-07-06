part of 'notify_bloc.dart';

abstract class NotifyState extends Equatable {
  const NotifyState();
}

class NotifyInitial extends NotifyState {
  @override
  List<Object> get props => [];
}

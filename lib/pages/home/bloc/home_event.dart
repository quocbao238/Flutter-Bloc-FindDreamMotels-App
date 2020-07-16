part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => null;
}

class OnClickListDistrictsEvent extends HomeEvent {
  final int index;
  OnClickListDistrictsEvent(this.index);
}

class OnClickListMotelssEvent extends HomeEvent {
  final int index;
  OnClickListMotelssEvent(this.index);
}

class FeatchDataEvent extends HomeEvent {}

class NewMotelEvent extends HomeEvent{}

part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class OnClickListDistrictsState extends HomeState {
  final int index;
  OnClickListDistrictsState(this.index);
}


class OnClickListMotelssState extends HomeState{
  final int index;
  OnClickListMotelssState(this.index);
}
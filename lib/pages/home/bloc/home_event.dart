part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => null;
}

class OnClickListDistrictsEvent extends HomeEvent {
  final DistrictModel districtModel;
  OnClickListDistrictsEvent(this.districtModel);
}

class OnClickListMotelssEvent extends HomeEvent {
  final MotelModel motelModel;
  OnClickListMotelssEvent(this.motelModel);
}

class FeatchDataEvent extends HomeEvent {
  
}

class NewMotelEvent extends HomeEvent{}

part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class LoadingMotels extends HomeState {}

class FeatchDataSucesesState extends HomeState {
  // final List<DistrictModel> listDistrict;
  final List<MotelModel> listMotel;
  FeatchDataSucesesState({ this.listMotel});
}

class FeatchDataFailState extends HomeState {}

class OnTapHotelsState extends HomeState{}

class OnClickListDistrictsState extends HomeState {
  final DistrictModel selectMotel;
  final List<MotelModel> listMotel;
  OnClickListDistrictsState({this.selectMotel,this.listMotel});
}

class OnClickListMotelssState extends HomeState {
  final MotelModel motelModel;
  OnClickListMotelssState(this.motelModel);
}

class NewMotelState extends HomeState {}

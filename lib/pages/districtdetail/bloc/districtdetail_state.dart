part of 'districtdetail_bloc.dart';

abstract class DistrictdetailState extends Equatable {
  const DistrictdetailState();
  @override
  List<Object> get props => [];
}

class DistrictdetailInitial extends DistrictdetailState {}

class LoadingDistrictDetail extends DistrictdetailState {}

class DistrictdetailError extends DistrictdetailState{}

class FeatchDistrictMotelSucessState extends DistrictdetailState {
  final List<MotelModel> list;
  FeatchDistrictMotelSucessState(this.list);
}

class GoToDetailState extends DistrictdetailState {
  final MotelModel motelModel;
  GoToDetailState(this.motelModel);
}

class OnTapDirectionState extends DistrictdetailState {
    final MotelModel motelModel;
  OnTapDirectionState(this.motelModel);
}
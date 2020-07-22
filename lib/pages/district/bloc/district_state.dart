part of 'district_bloc.dart';

abstract class DistrictState extends Equatable {
  const DistrictState();
  @override
  List<Object> get props => [];
}

class DistrictInitial extends DistrictState {}

class LoadingDistrictState extends DistrictState {}

class FeatchDistrictSucessState extends DistrictState {
  final List<DistrictModel> listDistrict;
  FeatchDistrictSucessState(this.listDistrict);
}

class DistrictErrorState extends DistrictState {
  final String errorMessage;
  DistrictErrorState(this.errorMessage);
}

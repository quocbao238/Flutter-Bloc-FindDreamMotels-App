part of 'newmotel_bloc.dart';

abstract class NewmotelState extends Equatable {
  const NewmotelState();
  @override
  List<Object> get props => [];
}

class NewmotelInitial extends NewmotelState {}

class LoadingState extends NewmotelState {}

class OnTapSelectDistrictSucessState extends NewmotelState {
  final String district;
  OnTapSelectDistrictSucessState(this.district);
}

class OnTapSelectDistrictFailState extends NewmotelState {}

class OnTapSelectAmenitiesSucessState extends NewmotelState {
  final List<Amenity> lstamenities;
  OnTapSelectAmenitiesSucessState(this.lstamenities);
}

class OnTapSelectAmenitiesFailState extends NewmotelState {}

class OnTapSelectImgSucessState extends NewmotelState {
  final List<Asset> listImg;
  OnTapSelectImgSucessState(this.listImg);
}

class OnTapSelectImgFailState extends NewmotelState {}

class OnTapCreatePostSucessState extends NewmotelState {}

class OnTapCreatePostFailState extends NewmotelState {
  final String errorMessage;
  OnTapCreatePostFailState({this.errorMessage});
}

class ChangeAddressEditState extends NewmotelState {
  final String address;
  final LatLng  latLng;
  ChangeAddressEditState(this.address, this.latLng);
}

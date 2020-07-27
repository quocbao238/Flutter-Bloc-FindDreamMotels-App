part of 'motel_detail_bloc.dart';

abstract class MotelDetailState extends Equatable {
  const MotelDetailState();
  @override
  List<Object> get props => [];
}

class MotelDetailInitial extends MotelDetailState {}

class LoadingState extends MotelDetailState {}

class FeatchDataSucessState extends MotelDetailState {
  final bool isFv;
  FeatchDataSucessState(this.isFv);
}

class OnTapFavoriteSucessState extends MotelDetailState {
  final bool isFv;
  OnTapFavoriteSucessState(this.isFv);
}

class OnTapFavoriteRemoveState extends MotelDetailState {
  final bool isFv;
  OnTapFavoriteRemoveState(this.isFv);
}

class FailState extends MotelDetailState {
  final String errorString;
  FailState(this.errorString);
}

class OnTapMapState extends MotelDetailState {
  final MotelModel motelModel;
  OnTapMapState(this.motelModel);
}

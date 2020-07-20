part of 'motel_detail_bloc.dart';

abstract class MotelDetailEvent extends Equatable {
  const MotelDetailEvent();
  @override
  List<Object> get props => [];
}

class OnTapFavoriteEvent extends MotelDetailEvent {
  final bool isFavorite;
  final MotelModel motel;
  OnTapFavoriteEvent({this.isFavorite, this.motel});
}

class FeatchDataEvent extends MotelDetailEvent {
  final MotelModel motelModel;
  FeatchDataEvent(this.motelModel);
}

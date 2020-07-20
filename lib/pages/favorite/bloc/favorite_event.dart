part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
  @override
  List<Object> get props => [];
}

class FeatchFavoriteListEvent extends FavoriteEvent {}

class GoToDetailEvent extends FavoriteEvent {
  final MotelModel motelModel;
  GoToDetailEvent(this.motelModel);
}

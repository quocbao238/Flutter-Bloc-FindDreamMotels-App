part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FeatchFavoriteListSucessState extends FavoriteState {
  final List<MotelModel> listMotel;
  FeatchFavoriteListSucessState(this.listMotel);
}

class FavoriteLoadingState extends FavoriteState{}

class OnFailState extends FavoriteState {
  final String errorMessage;
  OnFailState(this.errorMessage);
}

class GoToDetailState extends FavoriteState {
  final MotelModel motelModel;
  GoToDetailState(this.motelModel);
}

part of 'tutorial_bloc.dart';

abstract class TutorialState extends Equatable {
  const TutorialState();
}

class TutorialInitial extends TutorialState {
  @override
  List<Object> get props => [];
}

part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object> get props => [];
}

class ShowBottomSheetEvent extends SearchEvent {
  final BuildContext buildContext;

  ShowBottomSheetEvent(this.buildContext);
}

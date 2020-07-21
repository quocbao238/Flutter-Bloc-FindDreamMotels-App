part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchErrorState extends SearchState {
  final String errorMessage;
  SearchErrorState({this.errorMessage});
}

class ShowBottomSheetStateSucess extends SearchState {
  final int typeFilter;
  ShowBottomSheetStateSucess(this.typeFilter);
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:findingmotels/pages/widgets/showBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is ShowBottomSheetEvent) {
      int typeFilter = await displayBottomSheet(
          context: event.buildContext, list: listDisplaySearchBar);
      if (typeFilter != null) {
        yield ShowBottomSheetStateSucess(typeFilter);
      } else {
        yield SearchErrorState(errorMessage: '');
      }
    }
    yield SearchInitial();
  }
}

List<DisPlayBottomMotel> listDisplaySearchBar = [
  DisPlayBottomMotel(icon: Icons.search, title: 'Hotels'),
  DisPlayBottomMotel(icon: Icons.search, title: 'District'),
  // DisPlayBottomMotel(icon: Icons.search, title: 'District'),
  // DisPlayBottomMotel(icon: Icons.search, title: 'District'),
];

String getFilterName(int typeFilter) {
  return listDisplaySearchBar[typeFilter].title;
}

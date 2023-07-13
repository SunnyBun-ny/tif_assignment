import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment/apis/apis.dart';
import 'package:tif_assignment/models/model_event.dart';
import 'package:tif_assignment/screens/screen_search_event/bloc_search_event/search_events.dart';
import 'package:tif_assignment/screens/screen_search_event/bloc_search_event/search_states.dart';

class SearchEventBloc extends Bloc<SearchEvents, SearchStates> {
  List<ModelEvent> _listOfEvents = List.empty(growable: true);
  SearchEventBloc() : super(InitialSearchState()) {
    searchEvents('');

    on<SearchQueryEvent>((event, emit) => searchEvents(event.query.toString()));
  }

  void searchEvents(String query) async {
    emit(EventsLoadingState());
    try {
      _listOfEvents = await Apis().searchEvents(query);
      emit(EventsFetchedState(listOfEvents: _listOfEvents));
    } catch (e) {
      emit(EventsFetchingError(error: e.toString()));
    }
  }
}

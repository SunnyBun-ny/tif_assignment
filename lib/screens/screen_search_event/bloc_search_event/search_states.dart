import 'package:tif_assignment/models/model_event.dart';

abstract class SearchStates {}

class InitialSearchState extends SearchStates {}

class EventsLoadingState extends SearchStates {}

class EventsFetchedState extends SearchStates {
  final List<ModelEvent> listOfEvents;

  EventsFetchedState({required this.listOfEvents});
}

class EventsFetchingError extends SearchStates {
  final String error;

  EventsFetchingError({required this.error});
}

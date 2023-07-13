import 'package:tif_assignment/models/model_event.dart';

abstract class ListStates {}

class InitialListState extends ListStates {}

class FetchErrorState extends ListStates {
  final String error;
  FetchErrorState({
    required this.error,
  });
}

class ListLoadingState extends ListStates {}

class EventsFetchedState extends ListStates {
  final List<ModelEvent> listOfEvents;

  EventsFetchedState({required this.listOfEvents});
}

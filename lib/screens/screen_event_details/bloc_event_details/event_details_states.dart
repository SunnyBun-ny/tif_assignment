import 'package:tif_assignment/models/model_event.dart';

abstract class EventDetailsStates {}

class InitialEventDetialsState extends EventDetailsStates {}

class DetailsLoadingState extends EventDetailsStates {}

class DetailsFetched extends EventDetailsStates {
  final ModelEvent eventDetails;
  DetailsFetched({required this.eventDetails});
}

class DetailsScreenErrorState extends EventDetailsStates {
  final String error;
  DetailsScreenErrorState({required this.error});
}

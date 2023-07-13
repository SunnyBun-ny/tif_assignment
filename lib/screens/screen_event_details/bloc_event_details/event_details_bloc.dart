import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment/apis/apis.dart';
import 'package:tif_assignment/models/model_event.dart';
import 'package:tif_assignment/screens/screen_event_details/bloc_event_details/event_details_event.dart';
import 'package:tif_assignment/screens/screen_event_details/bloc_event_details/event_details_states.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvents, EventDetailsStates> {
  EventDetailsBloc() : super(InitialEventDetialsState()) {
    on<FetchEventDetails>((event, emit) => fetchEventDetails(event.eventId));
  }
  void fetchEventDetails(int eventId) async {
    emit(DetailsLoadingState());
    try {
      ModelEvent event = await Apis().getEventDetails(eventId);
      emit(DetailsFetched(eventDetails: event));
    } catch (e) {
      emit(DetailsScreenErrorState(error: e.toString()));
    }
  }
}

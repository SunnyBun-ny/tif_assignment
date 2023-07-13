import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment/apis/apis.dart';
import 'package:tif_assignment/models/model_event.dart';
import 'package:tif_assignment/screens/screen_events/bloc_events/list_events.dart';
import 'package:tif_assignment/screens/screen_events/bloc_events/list_states.dart';

class ListBloc extends Bloc<ListEvents, ListStates> {
  List<ModelEvent> _listOfEvents = List.empty(growable: true);
  ListBloc() : super(InitialListState()) {
    emit(ListLoadingState());
    fetchEvents();
  }
  fetchEvents() async {
    try {
      _listOfEvents = await Apis().getAllEvents();
      emit(EventsFetchedState(listOfEvents: _listOfEvents));
    } catch (e) {
      emit(FetchErrorState(error: e.toString()));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment/screens/screen_event_details/bloc_event_details/event_details_bloc.dart';
import 'package:tif_assignment/screens/screen_event_details/screen_event_details.dart';
import 'package:tif_assignment/screens/screen_events/bloc_events/list_bloc.dart';
import 'package:tif_assignment/screens/screen_events/screen_events.dart';
import 'package:tif_assignment/screens/screen_search_event/bloc_search_event/search_event_bloc.dart';
import 'package:tif_assignment/screens/screen_search_event/screen_search_event.dart';

void main() {
  runApp(EventsApp());
}

class EventsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ListBloc(),
        ),
        BlocProvider(
          create: (context) => SearchEventBloc(),
        ),
        BlocProvider(
          create: (context) => EventDetailsBloc(),
        )
      ],
      child: MaterialApp(
          theme: ThemeData(fontFamily: 'Inter', canvasColor: Colors.white),
          initialRoute: ScreenEvents.route,
          routes: {
            ScreenEvents.route: (context) => const ScreenEvents(),
            ScreenSearchEvent.route: (context) => ScreenSearchEvent(),
            ScreenEventDetails.route: (context) => const ScreenEventDetails()
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment/helper/helper_colors.dart';
import 'package:tif_assignment/helper/helper_fonts.dart';
import 'package:tif_assignment/screens/screen_event_details/bloc_event_details/event_details_bloc.dart';
import 'package:tif_assignment/screens/screen_event_details/bloc_event_details/event_details_event.dart';
import 'package:tif_assignment/screens/screen_event_details/screen_event_details.dart';
import 'package:tif_assignment/screens/screen_events/bloc_events/list_states.dart';
import 'package:tif_assignment/screens/screen_search_event/screen_search_event.dart';
import 'package:tif_assignment/widgets/widget_event_card.dart';

import 'bloc_events/list_bloc.dart';

class ScreenEvents extends StatelessWidget {
  static String route = '/screen-events';

  const ScreenEvents({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(
              left: 32,
              right: 24,
              top: 4,
              bottom: 4,
            ),
            child: Row(children: [
              Expanded(
                child: Text('Events',
                    style: HelperFonts.title(HelperColors.title, 24, 29.05)),
              ),
              InkWell(
                  onTap: () => _onTapSearch(context),
                  child: Image.asset('assets/icons/search.png')),
              const SizedBox(width: 16),
              Image.asset('assets/icons/more-vertical.png'),
            ]),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ListBloc, ListStates>(
                builder: (context, state) {
                  return state is EventsFetchedState
                      ? ListView.separated(
                          padding: const EdgeInsets.all(24),
                          itemBuilder: (context, index) => WidgetEventCard(
                            event: state.listOfEvents[index],
                            onTap: () => _onTapCard(
                                context, state.listOfEvents[index].id),
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemCount: state.listOfEvents.length,
                          physics: const BouncingScrollPhysics(),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                          color: HelperColors.primaryColor,
                        ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _onTapSearch(BuildContext context) {
    Navigator.of(context).pushNamed(ScreenSearchEvent.route);
  }

  _onTapCard(BuildContext context, int id) {
    BlocProvider.of<EventDetailsBloc>(context)
        .add(FetchEventDetails(eventId: id));
    Navigator.of(context).pushNamed(ScreenEventDetails.route);
  }
}

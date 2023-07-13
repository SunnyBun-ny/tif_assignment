import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment/helper/helper_colors.dart';
import 'package:tif_assignment/helper/helper_fonts.dart';
import 'package:tif_assignment/screens/screen_event_details/bloc_event_details/event_details_bloc.dart';
import 'package:tif_assignment/screens/screen_event_details/bloc_event_details/event_details_event.dart';
import 'package:tif_assignment/screens/screen_event_details/screen_event_details.dart';
import 'package:tif_assignment/screens/screen_search_event/bloc_search_event/search_event_bloc.dart';
import 'package:tif_assignment/screens/screen_search_event/bloc_search_event/search_events.dart';
import 'package:tif_assignment/screens/screen_search_event/bloc_search_event/search_states.dart';
import 'package:tif_assignment/widgets/widget_event_card.dart';

class ScreenSearchEvent extends StatelessWidget {
  static String route = '/screen-search-event';

  final TextEditingController _controllerSearchBar = TextEditingController();
  ScreenSearchEvent({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 4,
              bottom: 4,
            ),
            child: Row(
              children: [
                InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Image.asset('assets/icons/arrow-left.png')),
                const SizedBox(width: 12),
                Text('Search',
                    style: HelperFonts.title(HelperColors.title, 24, 29.05)),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 24, right: 24),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/search.png',
                    color: HelperColors.searchBar,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    height: 32,
                    child: VerticalDivider(
                      width: 2,
                      thickness: 2,
                      color: HelperColors.searchBar,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controllerSearchBar,
                      onChanged: (text) => _onChangedText(context, text),
                      style: HelperFonts.subTitle(Colors.black, 20, 24.2),
                      cursorColor: HelperColors.searchBar,
                      decoration: InputDecoration(
                          hintText: 'Type Event Name',
                          hintStyle:
                              HelperFonts.subTitle(Colors.grey, 20, 24.2),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchEventBloc, SearchStates>(
                builder: (context, state) {
                  return state is EventsFetchedState
                      ? state.listOfEvents.isEmpty
                          ? Center(
                              child: Text('No results found!',
                                  style: HelperFonts.subTitle(
                                      Colors.grey, 20, 24.2)))
                          : ListView.separated(
                              padding: const EdgeInsets.all(24),
                              itemBuilder: (context, index) => WidgetEventCard(
                                cardType: CardType.searchCard,
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

  _onChangedText(
    BuildContext context,
    String text,
  ) {
    BlocProvider.of<SearchEventBloc>(context)
        .add(SearchQueryEvent(query: text));
  }

  _onTapCard(BuildContext context, int id) {
    BlocProvider.of<EventDetailsBloc>(context)
        .add(FetchEventDetails(eventId: id));
    Navigator.of(context).pushNamed(ScreenEventDetails.route);
  }
}

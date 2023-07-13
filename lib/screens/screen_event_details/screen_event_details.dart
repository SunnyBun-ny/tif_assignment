import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tif_assignment/helper/helper_colors.dart';
import 'package:tif_assignment/helper/helper_font_height.dart';
import 'package:tif_assignment/helper/helper_fonts.dart';
import 'package:tif_assignment/screens/screen_event_details/bloc_event_details/event_details_bloc.dart';
import 'package:tif_assignment/screens/screen_event_details/bloc_event_details/event_details_states.dart';

class ScreenEventDetails extends StatelessWidget {
  static String route = '/screen-event-details';
  const ScreenEventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Colors.white.withOpacity(0), Colors.white],
              ),
            ),
          ),
          Positioned(bottom: 24, left: 0, right: 0, child: _button()),
        ],
      ),
      body: BlocBuilder<EventDetailsBloc, EventDetailsStates>(
        builder: (context, state) {
          if (state is DetailsFetched) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  titleSpacing: 0,
                  expandedHeight: 165,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
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
                            onTap: () {
                              SystemChrome.setSystemUIOverlayStyle(
                                  SystemUiOverlayStyle(
                                      statusBarColor: Colors.white));
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              'assets/icons/arrow-left.png',
                              color: Colors.white,
                            )),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text('Event Details',
                              style:
                                  HelperFonts.title(Colors.white, 24, 29.05)),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Image.asset('assets/icons/fav-icon.png'),
                        )
                      ],
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      state.eventDetails.bannerImage,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 180),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.eventDetails.title,
                                    style: HelperFonts.subTitle(
                                        HelperColors.title, 35, 42.36)),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 54,
                                      height: 51.68,
                                      child: Image.network(
                                          state.eventDetails.organiserIcon),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.eventDetails.organiserName,
                                          style: TextStyle(
                                            color: const Color(0xFF0D0C26),
                                            fontSize: 15,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 20.0.toFigmaHeight(15),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 2),
                                        const Text(
                                          'Organizer',
                                          style: TextStyle(
                                            color: Color(0xFF6F6D8F),
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 22),
                                _detailCard(
                                    Image.asset('assets/icons/date.png'),
                                    DateFormat('d MMMM, yyyy')
                                        .format(state.eventDetails.dateTime),
                                    '${DateFormat('EEEE, h:mm a').format(state.eventDetails.dateTime)} - ${DateFormat('h:mm a').format(state.eventDetails.dateTime.add(Duration(hours: 3)))}'),
                                const SizedBox(height: 24),
                                _detailCard(
                                    Image.asset('assets/icons/location.png'),
                                    state.eventDetails.venueName,
                                    '${state.eventDetails.venueCity}, ${state.eventDetails.venueCountry}'),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'About event',
                              style: TextStyle(
                                color: Color(0xFF110C26),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 34.0.toFigmaHeight(18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.eventDetails.description,
                            style: TextStyle(
                              color: Color(0xFF110C26),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 28.0.toFigmaHeight(16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                )
              ],
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: HelperColors.primaryColor,
            ));
          }
        },
      ),
    );
  }

  Widget _getIcon(Widget child) => Container(
        width: 48,
        height: 48,
        decoration: ShapeDecoration(
          color: HelperColors.primaryColor.withOpacity(0.10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: child,
      );

  Widget _detailCard(Widget icon, String title, String subTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _getIcon(icon),
        const SizedBox(width: 14),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: HelperFonts.title(Color(0xFF110C26), 16, 20)),
            const SizedBox(height: 2),
            Text(
              subTitle,
              style: const TextStyle(
                color: Color(0xFF6F6D8F),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _button() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 52),
        padding:
            const EdgeInsets.only(top: 14, bottom: 14, left: 85, right: 14),
        decoration: ShapeDecoration(
            color: HelperColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Book Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
            ),
            Image.asset('assets/icons/right_arrow.png')
          ],
        ),
      );
}

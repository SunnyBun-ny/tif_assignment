import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tif_assignment/helper/helper_colors.dart';
import 'package:tif_assignment/helper/helper_device_metadata.dart';
import 'package:tif_assignment/helper/helper_fonts.dart';
import 'package:tif_assignment/models/model_event.dart';

enum CardType { eventCard, searchCard }

class WidgetEventCard extends StatelessWidget {
  ModelEvent event;
  VoidCallback onTap;
  CardType cardType;
  WidgetEventCard({
    super.key,
    this.cardType = CardType.eventCard,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: context.height(106),
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 2),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0F575C8A),
              blurRadius: 35,
              offset: Offset(0, 10),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 79,
                height: 92,
                color: HelperColors.subColor,
                child: Image.network(
                  event.bannerImage,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${DateFormat("EEE, MMM d").format(event.dateTime)} • ${DateFormat('h:mm a').format(event.dateTime)}',
                      style: HelperFonts.subTitle(
                          HelperColors.primaryColor, 13, 15.73)),
                  const SizedBox(height: 4),
                  Text(event.title,
                      style: HelperFonts.title(HelperColors.title, 15,
                          cardType == CardType.eventCard ? 18.15 : 25)),
                  const SizedBox(height: 12),
                  cardType == CardType.eventCard
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('assets/icons/map-pin.png'),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '${event.venueName} • ${event.venueCity}, ${event.venueCountry}',
                                style: HelperFonts.subTitle(
                                    HelperColors.subColor, 13, 15.73),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

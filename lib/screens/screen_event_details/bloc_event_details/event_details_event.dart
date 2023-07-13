abstract class EventDetailsEvents {}

class FetchEventDetails extends EventDetailsEvents {
  final int eventId;
  FetchEventDetails({required this.eventId});
}

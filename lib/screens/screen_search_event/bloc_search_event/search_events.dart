abstract class SearchEvents {}

class SearchQueryEvent extends SearchEvents {
  final String query;

  SearchQueryEvent({required this.query});
}

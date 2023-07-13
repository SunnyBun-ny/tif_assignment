import 'dart:convert';

List<ModelEvent> modelEventFromJson(String str) => List<ModelEvent>.from(
        ((json.decode(str) as Map)['content']['data'] as List).map(
      (e) => ModelEvent.fromJson(e),
    ));

class ModelEvent {
  final int id;
  final String title;
  final String description;
  final String bannerImage;
  final DateTime dateTime;
  final String organiserName;
  final String organiserIcon;
  final String venueName;
  final String venueCity;
  final String venueCountry;

  ModelEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.bannerImage,
    required this.dateTime,
    required this.organiserName,
    required this.organiserIcon,
    required this.venueName,
    required this.venueCity,
    required this.venueCountry,
  });

  factory ModelEvent.fromJson(Map<String, dynamic> json) {
    return ModelEvent(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      bannerImage: json['banner_image'],
      dateTime: DateTime.parse(json['date_time']),
      organiserName: json['organiser_name'],
      organiserIcon: json['organiser_icon'],
      venueName: json['venue_name'],
      venueCity: json['venue_city'],
      venueCountry: json['venue_country'],
    );
  }

  toMapString() {
    return {
      'id': id,
      'title': title,
    }.toString();
  }
}

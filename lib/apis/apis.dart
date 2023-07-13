import 'dart:convert';

import 'package:tif_assignment/models/model_event.dart';
import 'package:http/http.dart' as http;

class Apis {
  final String _baseUrl =
      'https://sde-007.api.assignment.theinternetfolks.works';

  Future<List<ModelEvent>> getAllEvents() async {
    final String finalEndpoint = '$_baseUrl/v1/event';
    Uri finalUrl = Uri.parse(finalEndpoint);

    final response = await http.get(finalUrl);

    if (response.statusCode == 200) {
      List<ModelEvent> list = modelEventFromJson(response.body);
      return list;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<ModelEvent>> searchEvents(String query) async {
    final String finalEndpoint = '$_baseUrl/v1/event?search=$query';
    Uri finalUrl = Uri.parse(finalEndpoint);

    final response = await http.get(finalUrl);

    if (response.statusCode == 200) {
      List<ModelEvent> list = modelEventFromJson(response.body);
      return list;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ModelEvent> getEventDetails(int id) async {
    final String finalEndpoint = '$_baseUrl/v1/event/$id';
    Uri finalUrl = Uri.parse(finalEndpoint);

    final response = await http.get(finalUrl);

    if (response.statusCode == 200) {
      ModelEvent eventDetails = ModelEvent.fromJson(
          (json.decode(response.body) as Map)['content']['data']);

      return eventDetails;
    } else {
      throw Exception('Failed to load event');
    }
  }
}

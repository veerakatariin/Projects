import 'dart:convert';
import 'package:eventify_frontend/apis/models/interest_model.dart';
import 'package:eventify_frontend/apis/offline_data/interest_data.dart';
import 'package:http/http.dart' as http;

// Get all events from api
Future<List<InterestData>> fetchAllInterestData() async {
  final response =
      await http.get(Uri.parse('http://office.pepr.com:25252/Interests'));
  if (response.statusCode == 200 && response.body != '[]') {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new InterestData.fromJson(data)).toList();
  } else {
    List jsonResponseOffline = interests;
    return jsonResponseOffline
        .map((data) => new InterestData.fromJson(data))
        .toList();
  }
}

Future<InterestData> fetchSpecificInterestData(String id) async {
  final response =
      await http.get(Uri.parse('http://office.pepr.com:25252/Interests/$id'));
  if (response.statusCode == 200 && response.body != '[]') {
    var jsonResponse = json.decode(response.body);
    return InterestData.fromJson(jsonResponse);
    //return jsonResponse.map((data) => InterestData.fromJson(data)).toList();
  } else {
    var jsonResponse = json.decode(response.body);
    return InterestData.fromJson(jsonResponse);
    ;
  }
}

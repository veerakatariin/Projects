import 'dart:convert';
import 'package:eventify_frontend/apis/offline_data/event_from_id.dart';
import 'package:eventify_frontend/apis/offline_data/event_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/event_model.dart';

late SharedPreferences prefs;
bool prefsNoData = true;
bool prefsNoInterestData = true;

// Get all events from api
Future<List<EventData>> fetchAllEventsData() async {
  prefs = await SharedPreferences.getInstance();
  if (prefs.getString("allEvents") != null) {
    prefsNoData = false;
  } else {
    prefsNoData = true;
  }
  final response = await http
      .get(Uri.parse('http://office.pepr.com:25252/Event/getAllEvents'));
  if (response.statusCode == 200 && response.body != '[]') {
    prefs.setString("allEvents", json.encode(allEvents));
    List jsonResponse = json.decode(response.body);
    print('Request succeed with code 200: USING DATA FROM DATABASE');
    return jsonResponse.map((data) => new EventData.fromJson(data)).toList();
  } else {
    late List jsonResponseOffline;
    if (prefsNoData) {
      print(
          'Request failed and no data in Shared preferences: USING LOCAL DATA SAMPLES');
      jsonResponseOffline = allEvents;
      prefs.setString("allEvents", json.encode(allEvents));
    } else {
      print(
          'Request failed but there is recent data in Shared preferences: USING SHARED PREFERENCES');
      jsonResponseOffline = json.decode(prefs.getString("allEvents")!);
    }
    return jsonResponseOffline
        .map((data) => new EventData.fromJson(data))
        .toList();
  }
}

// Get event by id from api
Future<EventData> fetchEventFromId(int id) async {
  final response = await http
      .get(Uri.parse('http://office.pepr.com:25252/Event/GetEventById?Id=$id'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print('200');
    return EventData.fromJson(jsonDecode(response.body));
  } else {
    print('else');
    return EventData.fromJson((eventFromId));
  }
}

//Get event by one interest
Future<List<EventData>> fetchEventByInterest(int interestId) async {
  final response = await http.get(Uri.parse(
      'http://office.pepr.com:25252/Event/getEventsByInterest?interestId=$interestId'));

  if (response.statusCode == 200 && response.body != '[]') {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new EventData.fromJson(data)).toList();
  } else {
    print('result: ' + jsonDecode(response.body));
    throw Exception('Failed to fetch events with id $interestId');
  }
}

//get events by ids
Future<List<EventData>> fetchJoinedEvetns() async {
  prefs = await SharedPreferences.getInstance();
  String interests = prefs.getStringList("userEvents").toString();
  interests =
      interests.replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "");
  print(interests);
  if (prefs.getString("allEventsFromAllInterests") != null) {
    prefsNoInterestData = false;
  } else {
    prefsNoInterestData = true;
  }
  late List jsonResponseOffline;
  print(interests);
  final response = await http.get(
      Uri.parse('http://office.pepr.com:25252/Event/GetEvents?ids=$interests'));
  //here send given interests-list to server in query/header/whatever they'll make it to be.

  if (response.statusCode == 200) {
    print('Request succeed, using database');
    print(response.body);
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new EventData.fromJson(data)).toList();
  } else {
    jsonResponseOffline =
        json.decode(prefs.getString("allEventsFromAllInterests")!);
  }
  return jsonResponseOffline
      .map((data) => new EventData.fromJson(data))
      .toList();
}

//Get event by all your interests'
Future<List<EventData>> fetchEventsFromInterestsList() async {
  prefs = await SharedPreferences.getInstance();
  String interests = prefs.getStringList("userInterests").toString();
  interests =
      interests.replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "");
  print(interests);
  if (prefs.getString("allEventsFromAllInterests") != null) {
    prefsNoInterestData = false;
  } else {
    prefsNoInterestData = true;
  }
  late List jsonResponseOffline;
  print(interests);
  final response = await http.get(Uri.parse(
      'http://office.pepr.com:25252/Event/GetEventsByInterests?ids=$interests'));
  //here send given interests-list to server in query/header/whatever they'll make it to be.

  if (response.statusCode == 200) {
    print('Request succeed, using database');
    print(response.body);
    prefs.setString("allEventsFromAllInterests", json.encode(allEvents));
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new EventData.fromJson(data)).toList();
  } else {
    late List jsonResponseOffline;
    if (prefsNoInterestData) {
      print(
          'Request failed and no data in Shared preferences: USING LOCAL DATA SAMPLES');
      jsonResponseOffline = eventsOfInterestWithLocation;
      prefs.setString("allEventsFromAllInterests",
          json.encode(eventsOfInterestWithLocation));
    } else {
      print(
          'Request failed but there is recent data in Shared preferences: USING SHARED PREFERENCES');
      jsonResponseOffline =
          json.decode(prefs.getString("allEventsFromAllInterests")!);
    }
    return jsonResponseOffline
        .map((data) => new EventData.fromJson(data))
        .toList();
  }
}

// Post new Event to api
Future<EventData> createPostEvent(
  String description,
  String title,
  List tagList,
  bool locationBased,
  double latitude,
  double longitude,
  int hostId,
  int maxPeople,
  int minPeople,
  String startEvent,
  bool hasStarted,
) async {
  final response = await http.post(
      Uri.parse('http://office.pepr.com:25252/Event/CreateEvent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "description": description,
        "interests": tagList,
        "members": [0],
        "title": title,
        "locationBased": locationBased,
        "latitude": latitude,
        "longitude": longitude,
        "hostID": hostId,
        "maxPeople": maxPeople,
        "minPeople": minPeople,
        "startEvent": startEvent,
        "hasStarted": hasStarted
      }));
  print(json.encode(response.body));
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('result: ' + jsonDecode(response.body));
    return EventData.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print('resultti: no can do' + response.body);
    throw Exception('Failed to create event.');
  }
}

// Delete your own event from database
Future deleteEvent(String eventID) async {
  print(eventID);
  final response = await http.delete(
      Uri.parse('http://office.pepr.com:25252/Event/DeleteEvent?Id=$eventID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('event deleted: ' + response.body);
    return response.body;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print('event wasnt deleted' + response.body);
    throw Exception('Failed to create event.');
  }
}

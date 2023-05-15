import 'dart:convert';
import 'package:eventify_frontend/apis/models/user_model.dart';
import 'package:eventify_frontend/apis/offline_data/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

Future<UserData> fetchUserFromId(int id) async {
  prefs = await SharedPreferences.getInstance();
  String idString = id.toString();
  final response = await http
      .get(Uri.parse('http://office.pepr.com:25252/User/Details/$idString'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.statusCode);
    return UserData.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    return UserData.fromJson((user));
  }
}

Future addInterestPost(String interestId, String token) async {
  final response = await http.post(
      Uri.parse('http://office.pepr.com:25252/User/AddInterest/$interestId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      });

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('result: ' + response.body);
    return response.body;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print('resultti: ' + response.body);
    throw Exception('Failed to create event.');
  }
}

Future removeInterestDelete(String interestId, String token) async {
  final response = await http.delete(
      Uri.parse('http://office.pepr.com:25252/User/RemoveInterest/$interestId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      });

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('result: ' + response.body);
    return response.body;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print('resultti: ' + response.body);
    throw Exception('Failed to create event.');
  }
}

Future joinEvent(String eventID, String token) async {
  final response = await http.post(
      Uri.parse('http://office.pepr.com:25252/User/AttendEvent/$eventID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      });

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('result: ' + response.body);
    return response.body;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print('resultti: ' + response.body);
    throw Exception('Failed to create event.');
  }
}

Future leaveEvent(String eventID, String token) async {
  final response = await http.delete(
      Uri.parse('http://office.pepr.com:25252/User/UnattendEvent/$eventID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      });

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('result: ' + response.body);
    return response.body;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print('resultti: ' + response.body);
    throw Exception('Failed to create event.');
  }
}

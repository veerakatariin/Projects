import 'dart:convert';

import 'package:eventify_frontend/apis/models/user_model.dart';
import 'package:eventify_frontend/apis/offline_data/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

Future fetchTestToken() async {
  final response = await http.get(Uri.parse(
      'http://office.pepr.com:25252/login?email=frontend2@test.com&password=frontend2'));
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return response.body;
  } else {
    print(response.statusCode);
    return response.body;
  }
}

Future<MyUserData> fetchUserFromToken(String token) async {
  prefs = await SharedPreferences.getInstance();
  final response = await http.get(
      Uri.parse('http://office.pepr.com:25252/User/Details'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token
      });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return MyUserData.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    return MyUserData.fromJson((user));
  }
}

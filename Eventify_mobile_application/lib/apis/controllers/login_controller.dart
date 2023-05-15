import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

late SharedPreferences prefs;

Future<bool> registerUser(
    String username, String email, String password, String profileImg) async {
  print("register: " + username + email + password + profileImg);
  final response =
      await http.post(Uri.parse('http://office.pepr.com:25252/Login/Register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'username': username,
            'email': email,
            'password': password,
            'profileImg': profileImg,
          }));

  if (response.statusCode == 200) {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt', response.body);
    return true;
  } else {
    print({
      'username': username,
      'email': email,
      'password': password,
      'image': profileImg,
    });
    print('epäonnistui' + response.body);
    return false;
  }
}

Future<String> loginUser(String email, String password) async {
  final response = await http.get(
      Uri.parse(
          'http://office.pepr.com:25252/Login?email=$email&password=$password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

  if (response.statusCode == 200) {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt', response.body);
    return 'success';
  } else if (response.statusCode == 400) {
    print(response.statusCode);
    return 'invalid input';
  } else if (response.statusCode == 401) {
    print(response.statusCode);
    return 'invalid logindata';
  } else {
    print(response.statusCode);
    return 'error occured';
  }
}

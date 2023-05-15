import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:eventify_frontend/apis/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:eventify_frontend/profile/profile_view.dart';
import 'dart:math';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:fluttermoji/fluttermoji_assets/face/eyes/eyes.dart';
import 'package:fluttermoji/fluttermoji_assets/fluttermojimodel.dart';
import 'package:fluttermoji/fluttermoji_assets/style.dart';
import 'package:fluttermoji/fluttermoji_assets/top/hairStyles/hairStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

//edit profile information
// post/get into database later

String aaction = '';

class EditProfile extends StatefulWidget {
  final UserData userData;
  const EditProfile(this.userData, {Key? key}) : super(key: key);
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  //UserData user = 'UserInformation.myUser';
  List newValues = []; //0 = name, 1= email

  @override
  Widget build(BuildContext context) => Container(
          child: Builder(
        builder: (context) => Scaffold(
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 34),
            physics: BouncingScrollPhysics(),
            children: [
              /*Profile(
                path: user.path,
                edit: true,
                onClicked: () async {},
              ),*/
              const SizedBox(height: 25),
              TextFieldd(
                label: 'Name',
                text: widget.userData.name,
                onChanged: (name) {
                  newValues[0] = "";
                },
              ),
              const SizedBox(height: 24),
              TextFieldd(
                label: 'Email',
                text: widget.userData.email,
                onChanged: (email) {
                  newValues[1];
                },
              ),
              const SizedBox(height: 24),
              /*TextFieldd(
                label: 'Password',
                text: changePassword(user),
                onChanged: (password) {},
              ),
              const SizedBox(height: 24),
              TextFieldd(
                label: 'Description',
                text: user.description,
                maxlines: 5,
                onChanged: (description) {},
              ),*/
              const SizedBox(height: 24),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
            ],
          ),
        ),
      ));
}

class TextFieldd extends StatefulWidget {
  final int maxlines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldd({
    Key? key,
    this.maxlines = 1,
    required this.label,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  TextFielddState createState() => TextFielddState();
}

class TextFielddState extends State<TextFieldd> {
  late final TextEditingController controller;
  //User user = UserInformation.myUser;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: widget.maxlines,
          ),
        ],
      );
}

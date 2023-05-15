import 'package:eventify_frontend/apis/controllers/user_controller.dart';
import 'package:eventify_frontend/apis/models/user_model.dart';
import 'package:eventify_frontend/create_event/create_event_view.dart';
import 'package:eventify_frontend/profile/themes.dart';
import 'package:flutter/material.dart';

class MembersList extends StatefulWidget {
  final List? members;
  const MembersList(this.members);

  @override
  MembersListState createState() => MembersListState();
}

class MembersListState extends State<MembersList> {
  late Future<UserData> futureUserData;
  List<String> memberNames = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.members!.length; i++) {
      Future<void> kill = fetchUserFromId(widget.members![i])
          .then((value) => memberNames.add(value.name));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        color: Themes.fifth,
        child: ListView.builder(
            itemCount: memberNames.length,
            itemBuilder: (BuildContext context, int index) {
              print(memberNames);
              return Text((memberNames[index]).toString());
            }));
  }
}

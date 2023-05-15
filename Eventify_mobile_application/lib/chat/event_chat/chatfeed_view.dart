import 'package:eventify_frontend/apis/controllers/event_controller.dart';
import 'package:eventify_frontend/apis/controllers/interest_controller.dart';
import 'package:eventify_frontend/apis/models/interest_model.dart';
import 'package:eventify_frontend/chat/event_chat/chat_card.dart';
import 'package:eventify_frontend/chat/interest_chat/interest_card.dart';
import 'package:eventify_frontend/profile/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apis/controllers/chat_controller.dart';

class ChatFeed extends StatefulWidget {
  const ChatFeed({Key? key}) : super(key: key);

  @override
  _ChatFeedState createState() => _ChatFeedState();
}

class _ChatFeedState extends State<ChatFeed> {
  late Future<List> futureAllEventsData;
  late Future<List> futureJoinedEventsData;
  int _state = 1;
  var interests;
  var events;

  late SharedPreferences prefs;

  void changeView(int i) {
    setState(() {
      _state = i;
    });
    loadData();
  }

  loadData() async {
    prefs = await SharedPreferences.getInstance();
    interests = prefs.getStringList("userInterests");
    events = prefs.getStringList("userEvents");
  }

  void startConnection() async {
    connectService();
  }

  void stopConnection() async {
    disconnectService();
  }

  @override
  void initState() {
    super.initState();
    startConnection();
    futureAllEventsData = fetchAllEventsData();
    futureJoinedEventsData = fetchJoinedEvetns();
  }

  @override
  void dispose() {
    //stopConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
                height: 50,
                //padding: const EdgeInsets.all(1),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Themes.fifth,
                        margin: const EdgeInsets.all(3),
                        height: 40,
                        /*shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),*/
                        child: InkWell(
                          onTap: () {
                            changeView(1);
                          },
                          child: const Center(
                            child: Text(
                              "Events",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Themes.fifth,
                        margin: const EdgeInsets.all(3),
                        height: 40,
                        /*shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),*/
                        child: InkWell(
                          onTap: () {
                            changeView(2);
                          },
                          child: const Center(
                            child: Text(
                              "Interests",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
        body: _state == 1
            ? FutureBuilder<List>(
                future: futureJoinedEventsData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Center(
                        child: ChatCard(
                          snapshot.data![index],
                          /*int.parse("${snapshot.data![index].id}"),
                      snapshot.data![index].id.toString(),
                      snapshot.data![index].title,
                      snapshot.data![index].description,*/
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
            : Builder(builder: (context) {
                if (interests != null) {
                  return ListView.builder(
                    itemCount: interests.length,
                    itemBuilder: (_, index) => Center(
                      child: InterestCard(
                        interests[index],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }));
  }
}

import 'package:eventify_frontend/apis/controllers/event_controller.dart';
import 'package:eventify_frontend/apis/controllers/user_controller.dart';
import 'package:eventify_frontend/apis/models/event_model.dart';
import 'package:eventify_frontend/apis/models/user_model.dart';
import 'package:eventify_frontend/chat/event_chat/event_location.dart';
import 'package:eventify_frontend/event/event_creator.dart';
import 'package:eventify_frontend/event/members_list.dart';
import 'package:eventify_frontend/profile/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventCardView extends StatefulWidget {
  final int id;
  final int hostID;

  const EventCardView(this.id, this.hostID);

  @override
  EventCardState createState() => EventCardState();
}

class EventCardState extends State<EventCardView> {
  int state = 1;
  var _token;
  var _eventList;
  var _userID;

  late Future<EventData> futureEventData;

  @override
  void initState() {
    super.initState();
    futureEventData = fetchEventFromId(widget.id);
    LoadData();
  }

  late SharedPreferences prefs;
  void LoadData() async {
    prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("jwt");
    _eventList = prefs.getStringList("userEvents");
    _userID = prefs.getInt("userID");
    print(widget.hostID.toString());
    print(_token);
    print(widget.hostID.toString() + _userID.toString());
    if (widget.hostID == _userID) {
      setState(() {
        print("owner");
        state = 3;
      });
    } else if (widget.hostID != _userID &&
        _eventList!.contains(widget.id.toString())) {
      setState(() {
        print("contains");
        state = 2;
      });
    } else {
      setState(() {
        print("not contain");
        state = 1;
      });
    }
  }

  String dmy(String dtString) {
    final date = DateTime.parse(dtString);
    final format = DateFormat('d MMMM y - H:m');
    final clockString = format.format(date);

    return clockString;
  }

// handle join/leave button
  void HandleJoin(int joined) async {
    prefs = await SharedPreferences.getInstance();
    if (joined == 3) {
      deleteEvent(widget.id.toString());
      print("Deleting event");
      Navigator.pop(context);
    } else if (joined == 2) {
      leaveEvent(widget.id.toString(), _token);
      for (int i = 0; i < _eventList.length; i++) {
        //removeInterestDelete(unselect[i].toString(), userToken);
        print(_eventList[i]);
        if (_eventList[i].contains(widget.id.toString())) {
          print("removed" + _eventList[i].toString());
          _eventList.removeAt(i);
        }
        setState(() {
          print("leaving");
          state = 1;
        });
      }
    } else {
      _eventList.add(widget.id.toString());
      joinEvent(widget.id.toString(), _token);
      print("joining");
      setState(() {
        state = 2;
      });
    }

    prefs.setStringList("userEvents", _eventList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Themes.fourth,
        title: Text('EventCard'),
      ),
      body: (Container(
        color: Themes.white,
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<EventData>(
            future: futureEventData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    //Event title
                    Text(
                      snapshot.data!.title,
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),

                    //Event date + startTime
                    Text(
                      dmy(snapshot.data!.startEvent),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),

                    //Just a spacer container, any better solution?
                    Container(
                      width: double.infinity,
                      height: 20,
                    ),

                    //Event description
                    Row(children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          snapshot.data!.description.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      // protetcted view when joined
                      Column(children: [
                        //Joined / max

                        Row(
                          children: [
                            Text(
                              snapshot.data!.members!.length.toString() +
                                  "/" +
                                  snapshot.data!.maxPeople.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.person)
                          ],
                        ),
                        (state == 1)
                            ? (Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 200,
                                color: Themes.white,
                                child: Column(children: [
                                  Text(
                                      "You can see the members of this event when you join in")
                                ])))
                            : (state == 2)
                                ? (Container(
                                    alignment: Alignment.centerRight,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    height: 200,
                                    color: Themes.white,
                                    child: Column(children: [
                                      MembersList(snapshot.data!.members)
                                    ])))
                                : (Container(
                                    alignment: Alignment.centerRight,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    height: 200,
                                    color: Themes.white,
                                    child: Column(children: [
                                      MembersList(snapshot.data!.members)
                                    ]))),
                      ]),
                    ]),
                    //Just a spacer container, any better solution?
                    Container(
                      width: double.infinity,
                      height: 20,
                    ),

                    //Small map to show location in small scale.
                    (snapshot.data!.locationBased)
                        ? (SizedBox(
                            height: 160,
                            child: EventLocation(snapshot.data!.latitude!,
                                snapshot.data!.longitude!),
                          ))
                        : (Container()),
                    Container(height: 20),
                    EventCreator(widget.hostID),
                    Spacer(),
                    // protetcted view when joined
                    //Button to join/leave event
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 200,
                        height: 60,
                        color: Themes.fourth,
                        child: TextButton(
                          onPressed: () {
                            HandleJoin(state);
                          },
                          child: state == 1
                              ? Text(
                                  'Join Event',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : state == 2
                                  ? Text('Leave Event',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))
                                  : Text('Delete Event',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      )),
    );
  }
}

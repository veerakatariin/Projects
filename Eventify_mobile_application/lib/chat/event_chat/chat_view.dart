import 'dart:async';

import 'package:eventify_frontend/apis/controllers/event_controller.dart';
import 'package:eventify_frontend/apis/models/event_model.dart';
import 'package:eventify_frontend/event/eventcard_view.dart';
import 'package:eventify_frontend/profile/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../apis/controllers/chat_controller.dart';
import '../chat_message.dart';

class ChatView extends StatefulWidget {
  final int id;
  final int hostId;
  final String room;

  const ChatView(
      {required this.id, required this.room, required this.hostId, Key? key})
      : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late SharedPreferences prefs;
  dynamic hubConnection;
  late List<ChatMessage> messages = [];
  late String user;

  final scrollController = ScrollController();
  final textController = TextEditingController();

  late Future<EventData> futureEventFromId;

  void messageReceived(List<Object>? args) async {
    final String user = args![0].toString();
    final String message = args[1].toString();
    messages.add(ChatMessage.short(user, message));
    Timer(const Duration(milliseconds: 200), () => jump());
    setState(() {});
  }

  void getHistory() async {
    messages = await getMessageHistory(widget.room);
    Timer(const Duration(milliseconds: 200), () => jump());
    setState(() {});
  }

  void join() async {
    hubConnection = await getService();
    hubConnection.on('receiveMessage', messageReceived);
    await joinRoom(widget.room, user);
  }

  void initUser() async {
    prefs = await SharedPreferences.getInstance();
    user = prefs.getString('userName').toString();
  }

  void jump() {
    if (scrollController.hasClients) {
      final position = scrollController.position.maxScrollExtent;
      scrollController.jumpTo(position);
    }
  }

  void leave() async {
    await leaveRoom(widget.room, user);
  }

  @override
  void initState() {
    initUser();
    getHistory();
    jump();
    super.initState();
    futureEventFromId = fetchEventFromId(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Themes.appBar,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 6,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return EventCardView(widget.id, widget.hostId);
                          }));
                        },
                        child: FutureBuilder<EventData>(
                            future: futureEventFromId,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(children: [
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.title,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Text(
                                          "Tap Here to see event info",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text('1' +
                                        "/" +
                                        snapshot.data!.maxPeople
                                            .toString()), // <-- Text
                                  ),
                                ]);
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(children: [
        Expanded(
            child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              controller: scrollController,
              padding: EdgeInsets.only(top: 5, bottom: 5),
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 5, bottom: 5),
                      child: Align(
                        alignment:
                            (messages[index].user == user // ==prefs username?
                                ? Alignment.topRight
                                : Alignment.topLeft),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].user ==
                                    user // == prefs username?
                                ? Themes.fifth
                                : Themes.fourth),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            messages[index].message, //message
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: (messages[index].user == user
                            ? Alignment.topRight
                            : Alignment.topLeft),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                                ((messages[index].user == user
                                    ? 'You'
                                    : messages[index].user)),
                                style: TextStyle(fontSize: 10)))),
                  ],
                );
              },
            ),
          ],
        )),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                FloatingActionButton(
                  onPressed: () {
                    //send message to server
                    print(user);
                    sendMessage(user, textController.text, widget.room);
                    textController.text = '';
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 18,
                  ),
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

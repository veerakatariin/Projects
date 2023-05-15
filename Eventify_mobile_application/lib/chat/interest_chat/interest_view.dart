import 'dart:async';

import 'package:eventify_frontend/apis/controllers/chat_controller.dart';
import 'package:eventify_frontend/profile/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chat_message.dart';

class InterestChatView extends StatefulWidget {
  final int id;
  final String room;

  InterestChatView({required this.id, required this.room, Key? key})
      : super(key: key);

  @override
  _InterestChatViewState createState() => _InterestChatViewState();
}

class _InterestChatViewState extends State<InterestChatView> {
  late SharedPreferences prefs;
  dynamic hubConnection;
  late List<ChatMessage> messages = [];
  late String user;

  final scrollController = ScrollController();
  final textController = TextEditingController();

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
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
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
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
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
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: (messages[index].user == user
                            ? Alignment.topRight
                            : Alignment.topLeft),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                                ((messages[index].user == user
                                    ? 'You'
                                    : messages[index].user)),
                                style: const TextStyle(fontSize: 10)))),
                  ],
                );
              },
            ),
          ],
        )),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
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
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                FloatingActionButton(
                  onPressed: () {
                    //send message to server
                    sendMessage(user, textController.text, widget.room);
                    textController.text = '';
                  },
                  child: const Icon(
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

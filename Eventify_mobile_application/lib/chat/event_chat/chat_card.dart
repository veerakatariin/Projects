import 'dart:ffi';

import 'package:eventify_frontend/profile/themes.dart';
import 'package:flutter/material.dart';
import 'chat_view.dart';

class ChatCard extends StatelessWidget {
  final event;

  const ChatCard(this.event, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Themes.fifth,
        shadowColor: Themes.third,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: InkWell(
          splashColor: Themes.third,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChatView(
                  id: event.id, hostId: event.hostID, room: event.title);
            }));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5,
            ),
            child: SizedBox(
                height: 60,
                width: double.infinity,
                child: Column(
                  children: [
                    Text(event.title.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          event.description.toString(),
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Spacer(),
                        Text(event.members.length.toString() +
                            '/' +
                            event.maxPeople.toString()),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

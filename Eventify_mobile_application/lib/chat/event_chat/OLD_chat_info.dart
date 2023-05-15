import 'dart:async';
import 'dart:convert';

import 'package:eventify_frontend/chat/event_chat/chat_members.dart';
import 'package:eventify_frontend/chat/event_chat/event_location.dart';
import 'package:eventify_frontend/map/map_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../create_event/select_location.dart';

class ChatInfo extends StatelessWidget {
  int? id;
  String? title;
  String? description;
  double? latitude;
  double? longitude;
  bool locationBased;
  ChatInfo(
      {required this.id,
      required this.title,
      required this.description,
      required this.latitude,
      required this.longitude,
      required this.locationBased});

  @override
  Widget build(BuildContext context) {
    bool locationOnOff = locationBased;

    return Align(
        child: Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            width: double.infinity,
            color: Colors.orange[100],
            child: Column(children: [
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(bottom: 10),
                child: Text(title.toString(),
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.only(bottom: 10),
                color: Colors.orange[200],
                child: Text(description.toString(),
                    style: TextStyle(fontSize: 16)),
              ),
              Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(bottom: 10),
                  color: Colors.orange[200],
                  child: Text('Members: ')),
              (locationOnOff)
                  ? (SizedBox(
                      height: 60, child: EventLocation(latitude!, longitude!)))
                  : (Container())
            ])));
  }
}

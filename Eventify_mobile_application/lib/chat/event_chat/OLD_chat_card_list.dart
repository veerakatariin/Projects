import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';

import 'chat_view.dart';

class ChatCardList extends StatefulWidget {
  int id;
  int hostID;
  String title;
  String description;
  String dateTime;
  String locationBased;
  ChatCardList(
      {required this.id,
      required this.hostID,
      required this.title,
      required this.description,
      required this.dateTime,
      required this.locationBased});
  @override
  _ChatCardListState createState() => _ChatCardListState();
}

class _ChatCardListState extends State<ChatCardList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          /*Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatView(id: widget.id, hostID: widget.hostID);
          }));*/
        },
        child: Card(
            color: Colors.green[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Container(
                height: 110,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 16,
                            color: Colors.orange,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.lightBlue,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.title,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(widget.description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      softWrap: false,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade600)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 12,
                      color: Colors.yellowAccent,
                    ),
                    Center(
                        child: Column(children: [
                      Container(
                        color: Colors.amberAccent,
                        child: Text(
                          widget.dateTime.substring(0, 10),
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        height: 12,
                        color: Colors.red,
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: (widget.locationBased == "true")
                            ? (Image.asset(
                                "assets/images/golf.png",
                                scale: 5,
                              ))
                            : (Container()),
                      ),
                      Container(
                        width: 12,
                        color: Colors.green,
                      ),
                    ]))
                  ],
                ),
              ),
            )));
  }
}

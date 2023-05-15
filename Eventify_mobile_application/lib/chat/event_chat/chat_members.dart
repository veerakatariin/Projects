import 'package:flutter/material.dart';

class ChatMembers extends StatelessWidget {
  final String user;

  // ignore: use_key_in_widget_constructors
  const ChatMembers(this.user);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        user,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }
}

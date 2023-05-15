import 'package:flutter/material.dart';

//bool values for the notifications
//post/get into the database later

class SwitchEventNot extends StatefulWidget {
  const SwitchEventNot({Key? key}) : super(key: key);
  @override
  SwitchNot createState() => SwitchNot();
}

class SwitchNot extends State<SwitchEventNot> {
  bool isEventChat = false;

  void eventSwitch(bool value){
    if(isEventChat == false){
      setState(() {
        isEventChat = true;
      });
    } else {
      setState(() {
        isEventChat = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1,
          child: Switch(
            onChanged: eventSwitch,
            value: isEventChat,
            activeColor: Colors.blueAccent,
            activeTrackColor: Colors.lightBlueAccent,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.black54,
          ),
        ),
      ],
    );
  }
}

class SwitchInterestNot extends StatefulWidget {
  const SwitchInterestNot({Key? key}) : super(key: key);
  @override
  SwitchInterestNots createState() => SwitchInterestNots();
}

class SwitchInterestNots extends State<SwitchInterestNot> {
  bool isInterstChat = false;

  void interestSwitch(bool value){
    if(isInterstChat == false){
      setState(() {
        isInterstChat = true;
      });
    } else {
      setState(() {
        isInterstChat = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1,
          child: Switch(
            onChanged: interestSwitch,
            value: isInterstChat,
            activeColor: Colors.blueAccent,
            activeTrackColor: Colors.lightBlueAccent,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.black54,
          ),
        ),
      ],
    );
  }
}

class SwitchFeedNot extends StatefulWidget {
  const SwitchFeedNot({Key? key}) : super(key: key);
  @override
  SwitchFeedNots createState() => SwitchFeedNots();
}

class SwitchFeedNots extends State<SwitchFeedNot> {
  bool isFeed = false;

  void feedSwitch(bool value){
    if(isFeed == false){
      setState(() {
        isFeed = true;
      });
    } else {
      setState(() {
        isFeed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1,
          child: Switch(
            onChanged: feedSwitch,
            value: isFeed,
            activeColor: Colors.blueAccent,
            activeTrackColor: Colors.lightBlueAccent,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.black54,
          ),
        ),
      ],
    );
  }
}

import 'package:eventify_frontend/profile/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCardShortView extends StatelessWidget {
  final d;
  final VoidCallback cb;

  const EventCardShortView(this.d, this.cb);

  String dmy(String dtString) {
    final date = DateTime.parse(dtString);
    final format = DateFormat('d MMMM y - H:m');
    final clockString = format.format(date);

    return clockString;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Themes.fifth,
        shadowColor: Themes.fourth,
        margin: EdgeInsets.all(6.0),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(40),
          onTap: cb,
          child: SizedBox(
            width: double.infinity,
            height: 120,
            child: Column(
              children: [
                //Event title
                Text(
                  d.title.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),

                //Event Description
                Text(
                  d.description.toString(),
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),

                //joined/max
                Text(
                    d.members.length.toString() + '/' + d.maxPeople.toString()),

                const Spacer(),
                //Event time
                Text(dmy(d.startEvent)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

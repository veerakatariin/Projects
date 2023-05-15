import 'package:eventify_frontend/apis/controllers/interest_controller.dart';
import 'package:eventify_frontend/apis/models/interest_model.dart';
import 'package:eventify_frontend/chat/interest_chat/interest_view.dart';
import 'package:eventify_frontend/profile/themes.dart';
import 'package:flutter/material.dart';

class InterestCard extends StatefulWidget {
  final interest;

  const InterestCard(this.interest, {Key? key}) : super(key: key);

  @override
  State<InterestCard> createState() => _InterestCardState();
}

class _InterestCardState extends State<InterestCard> {
  late Future<InterestData> futureInterestData;

  @override
  void initState() {
    futureInterestData = fetchSpecificInterestData(widget.interest);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
              return InterestChatView(
                  id: int.parse(widget.interest),
                  room: widget.interest.toString());
            }));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: SizedBox(
                height: 60,
                width: double.infinity,
                child: Column(
                  children: [
                    FutureBuilder<InterestData>(
                        future: futureInterestData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!.name.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return const Text('notwork');
                          }
                        }),
                    const SizedBox(height: 10),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

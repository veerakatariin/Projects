import 'package:eventify_frontend/apis/controllers/interest_controller.dart';
import 'package:eventify_frontend/apis/controllers/user_controller.dart';
import 'package:eventify_frontend/apis/models/interest_model.dart';
import 'package:eventify_frontend/apis/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterestsCheckBoxList extends StatefulWidget {
  const InterestsCheckBoxList();
  @override
  InterestsCheckBoxListState createState() => InterestsCheckBoxListState();
}

class InterestsCheckBoxListState extends State<InterestsCheckBoxList> {
  List select = [];
  List unselect = [];
  var userToken;
  late Future<List<InterestData>> checkBoxListTileModel;
  late List copyList = [];
  var interestListFromApi = []; // Interest List from database
  var userInterests; // Users chosen interests
  late ScrollController _controller;
  var token;
  bool save_option = false;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    loadData();
    super.initState();
  }

  late SharedPreferences prefs;

  udpateInterests() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setStringList("userInterests", userInterests);
  }

  loadData() async {
    prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString("jwt");
    userInterests = prefs.getStringList("userInterests");
    interestListFromApi.clear();
    copyList.clear();
    token = prefs.getString("token");
    // Hakee kaikki interestit apilta ja listaa ne
    List<InterestData> interests = [];
    interests = await fetchAllInterestData();
    for (int i = 0; i < interests.length; i++) {
      interestListFromApi.add({
        'interestId': interests[i].id,
        'name': interests[i].name,
        'description': interests[i].description,
        'isCheck':
            userInterests.contains(interests[i].id.toString()) ? true : false
      });
      // copyList is for referral when choosing new interests
      copyList.add({
        'interestId': interests[i].id,
        'name': interests[i].name,
        'description': interests[i].description,
        'isCheck': userInterests.contains(i.toString()) ? true : false
      });
    }
    print(interestListFromApi);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 300,
          child: RawScrollbar(
              controller: _scrollController,
              isAlwaysShown: true,
              thumbColor: Colors.redAccent,
              radius: Radius.circular(20),
              thickness: 10,
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (3 / 1),
                ),
                itemCount: interestListFromApi.length,
                itemBuilder: (BuildContext context, int index) {
                  // ignore: unnecessary_new
                  return new Card(
                    //padding: EdgeInsets.all(10.0),

                    child: Column(
                      children: <Widget>[
                        CheckboxListTile(
                            activeColor: Colors.pink[300],
                            dense: true,
                            //font change
                            title: Text(
                              interestListFromApi[index]["name"],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5),
                            ),
                            value: interestListFromApi[index]["isCheck"],
                            onChanged: (bool? val) {
                              itemChange(val!, index);
                            })
                      ],
                    ),
                  );
                },
              ))),
      (save_option)
          ? Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.lightGreenAccent,
              child: TextButton(
                  onPressed: sendInterests,
                  child: Text('Save',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold))))
          : (Container())
    ]);
  }

  void itemChange(bool val, int index) {
    int a = 0;
    setState(() {
      print(interestListFromApi[index]["name"]);
      interestListFromApi[index]["isCheck"] = val;
      print(interestListFromApi[index]["isCheck"].toString() +
          copyList[index]["isCheck"].toString());
      save_option = true;
      copyList[index]["isCheck"] = val;
      if (val) {
        select.add(interestListFromApi[index]["interestId"].toString());
      } else {
        unselect.add((interestListFromApi[index]["interestId"].toString()));
      }
    });
  }

// This will send a list of all chosen interest id:s to api. Test in application to see
  void sendInterests() {
    setState(() {
      for (int i = 0; i < select.length; i++) {
        addInterestPost(select[i], userToken);
        userInterests.add(select[i]);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Processing Data: ' + select[i]),
        ));
      } //postData(checkBoxListTileModel, token);
      // add checkboxlisttilemodel to uri and authorisation key to body
      for (int i = 0; i < unselect.length; i++) {
        print("unselect: " + unselect.toString());
        removeInterestDelete(unselect[i].toString(), userToken);
        userInterests.remove(unselect[i]);
      }
      select.clear();
      unselect.clear();
      udpateInterests();
      loadData();
    });
  }
}

class CheckBoxListTileModel {
  int? interestId;
  String? name;
  String? description;
  bool? isCheck;

  CheckBoxListTileModel(
      {this.interestId, this.name, this.description, this.isCheck});
}

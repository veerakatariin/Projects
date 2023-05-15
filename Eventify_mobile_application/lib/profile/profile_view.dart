import 'package:eventify_frontend/apis/controllers/user_controller.dart';
import 'package:eventify_frontend/apis/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:eventify_frontend/profile/interests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';
import 'package:eventify_frontend/profile/themes.dart';
import 'package:eventify_frontend/profile/notifications.dart';

/* 
GET YOUR OWN USER INFORMATION MIHIN VAAN LUOKKAAN:

  late UserData futureUserFromIdData; // USER LUOKKA MITEN DATA TALLENTUU
  late SharedPreferences prefs;

  getUserInfo() async {
    prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("userID"); // USER ID ON KIRJAUTUMISVAIHEESSA TALLENNETTU SHARED PREFERENSIIN
    futureUserFromIdData = await fetchUserFromId(id); // VOI TEHDÄ AWAITILLA TAI WIDGETIN BUILDERISSA, ESIMERKKEJÄ: CHATFEED, MAPVIEW, EVENTCARD
    }
*/

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfilePage> {
  bool isPlatformDark = false;
  bool hasLoaded = false;
  String profilePic = "";

  late SharedPreferences prefs;
  late UserData futureUserFromIdData; // USER LUOKKA MITEN DATA TALLENTUU

// working thing get user info
  getUserInfo() async {
    prefs = await SharedPreferences.getInstance();
    profilePic = prefs.getString("userPic")!;
    int id = prefs.getInt(
        "userID")!; // USER ID ON KIRJAUTUMISVAIHEESSA TALLENNETTU SHARED PREFERENSIIN
    futureUserFromIdData = await fetchUserFromId(
        id); // VOI TEHDÄ AWAITILLA TAI WIDGETIN BUILDERISSA, ESIMERKKEJÄ: CHATFEED, MAPVIEW, EVENTCARD
    print(futureUserFromIdData.interests);
    setState(() {
      hasLoaded = true;
    });
  }

  changeTheme() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("darkMode") == "true") {
        prefs.setString("darkMode", "false");
        isPlatformDark = false;
      } else {
        prefs.setString("darkMode", "true");
        isPlatformDark = true;
      }
    });
  }

  logOut() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove("jwt");
      Navigator.pop(context);
    });
  }

  retrieveTheme() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("darkMode") == "true") {
        isPlatformDark = true;
      } else {
        isPlatformDark = false;
      }
    });
  }

  @override
  void initState() {
    getUserInfo();
    retrieveTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: isPlatformDark ? Themes.dark : Themes.light,
        home: Scaffold(
            body: (hasLoaded)
                ? (ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: logOut,
                                icon: Icon(
                                  Icons.key_off,
                                  size: 40,
                                )),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: changeTheme,
                                icon: Icon(
                                  Icons.bedtime_outlined,
                                  size: 40,
                                )),
                          ),
                        ],
                      ),
                      // This need to be on database to implement
                      Profile(
                          path: profilePic,
                          onClicked: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                        futureUserFromIdData)) //edit through a button
                                );
                          }),
                      const SizedBox(height: 25),
                      name(futureUserFromIdData),
                      const SizedBox(height: 24),
                      Ranking(),
                      const SizedBox(height: 25),
                      interests(futureUserFromIdData),
                      const SizedBox(height: 25),
                      /*description(user),
            const SizedBox(height: 24),
            password(user),
            const SizedBox(height: 25),*/
                      /*eventChatNot(),
                      const SizedBox(height: 25),
                      interestChatNot(),
                      const SizedBox(height: 25),
                      feedNot(),
                      const SizedBox(height: 25),*/
                      Container(
                        padding: EdgeInsets.only(left: 60, right: 60),
                        child: ElevatedButton(
                            child: Text('Edit Profile'),
                            onPressed: () => _editProfile(context)),
                      )
                    ],
                  ))
                : (Container())));
    /*),
      ),
    );*/
  }

  void _editProfile(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => EditProfile(futureUserFromIdData)),
    );
    print('result:' + '$result');
    setState(() {});
  }

  //name and email boxes
  Widget name(UserData user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
          SizedBox(height: 15),
          /*Text(
            'Seppo asuu Pihlajakadulla',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),*/
        ],
      );

  //password box
  Widget password(UserData user) => Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 4),
          /*Text(
            changePassword(user),
            style: TextStyle(fontSize: 16, height: 1.4),
          ),*/
        ],
      ));

  //biography box
  Widget description(UserData user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            /*Text(
              user.description,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),*/
          ],
        ),
      );

  //interests
  Widget interests(UserData user) => Card(
      color: Colors.greenAccent,
      child: Column(children: [
        Text('Chosen Interests:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        InterestsCheckBoxList()
      ]));

  Widget eventChatNot() => Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'Event chat notifications',
                  style: TextStyle(fontSize: 15),
                ),
                SwitchEventNot(),
              ],
            )
          ],
        ),
      );

  Widget interestChatNot() => Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'Interest chat notifications',
                  style: TextStyle(fontSize: 15),
                ),
                SwitchInterestNot(),
              ],
            )
          ],
        ),
      );

  Widget feedNot() => Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'Feed notifications',
                  style: TextStyle(fontSize: 15),
                ),
                SwitchFeedNot(),
              ],
            )
          ],
        ),
      );
}

class Profile extends StatelessWidget {
  final String path;
  final bool edit;
  final VoidCallback onClicked;

  const Profile({
    Key? key,
    required this.path,
    this.edit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 0,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  //profile picture
  Widget buildImage() {
    final image = AssetImage(path);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );
  }

  //edit profile through the picture
  Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 1,
        child: IconButton(
          onPressed: onClicked,
          icon: Icon(
            edit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

class Ranking extends StatelessWidget {
  int rank = 0;
  int friends = 0;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          numberButton(context, rank, 'Ranking'),
          divider(),
          numberButton(context, friends, 'Friends'),
        ],
      );

  Widget divider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget numberButton(BuildContext context, int value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              value.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          onPrimary: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}

/*AppBar appBar(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.lightBlueAccent,
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: Icon(icon),
          onPressed: () {
            final theme = isDarkMode ? Themes.light : Themes.dark;

            final switcher = ThemeSwitcher.of(context);
            switcher.changeTheme(theme: theme);
          },
        ),
      ),
    ],
  );
}*/

import 'package:eventify_frontend/apis/models/user_model.dart';
import 'package:eventify_frontend/chat/event_chat/chatfeed_view.dart';
import 'package:eventify_frontend/create_event/create_event_view.dart';
import 'package:eventify_frontend/feed/homefeed_view.dart';
import 'package:eventify_frontend/login/login_view.dart';
import 'package:eventify_frontend/map/map_view.dart';
import 'package:eventify_frontend/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eventify_frontend/profile/themes.dart';

import 'apis/controllers/test_login_controller.dart';
import 'profile/themes.dart';

// sprint 3
void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _state = 1;
  bool _authState =
      false; // false: not logged in (show login), true: logged in (show application)
  int _navState = 1;
  bool settings = false;

  late MyUserData futureUserFromToken;

  late SharedPreferences prefs;
  late bool isPlatformDark;

  retrieve() async {
    prefs = await SharedPreferences.getInstance();
// get user info from api. Get user ID later in any class from json.encode(prefs.getString("userID"));
    //var testawt = await fetchTestToken();
    String token = prefs.getString("jwt").toString();
    print('token: ' + token);
    futureUserFromToken = await fetchUserFromToken(
        token); // Later this should be done when anbd only when login is done
    //String tring = json.encode(futureUserFromIdData);
    List<String> interestListFromIdData =
        futureUserFromToken.interests.map((s) => s.toString()).toList();
    List<String> eventListFromIdData =
        futureUserFromToken.events.map((s) => s.toString()).toList();
    print("pic: " + futureUserFromToken.profileImg);
    prefs.setString("userPic", futureUserFromToken.profileImg);
    prefs.setInt("userID", futureUserFromToken.id);
    prefs.setString("userName", futureUserFromToken.name);
    prefs.setString("userEmail", futureUserFromToken.email);
    prefs.setStringList("userInterests", interestListFromIdData);
    prefs.setStringList("userEvents", eventListFromIdData);
    print("info" +
        prefs.getInt("userID")!.toString() +
        prefs.getString("userName").toString() +
        prefs.getString("userEmail").toString() +
        prefs.getStringList("userInterests").toString() +
        prefs.getStringList("userEvents").toString() +
        prefs.getString("userPic").toString());
    // Check theme
    setState(() {
      if (prefs.getString("darkMode") == "true") {
        isPlatformDark = true;
        initTheme = isPlatformDark ? Themes.dark : Themes.light;
      } else {
        isPlatformDark = false;
        initTheme = isPlatformDark ? Themes.dark : Themes.light;
      }
      _authState = true;
    });
  }

  @override
  void initState() {
    // here function to check if jwt is valid, if not: authstate = false, if yes = auth_state = true
    checkAuth();
    super.initState();
  }

  void checkAuth() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("jwt") != null) {
        if (prefs.getString("jwt")!.length > 20) {
          _authState = true;
        }
      } else {
        _authState = false;
      }
      retrieve();
    });
  }

  dynamic initTheme;

  // State määrittää näytettävän näkymän
  void _stateCounter(int i) {
    setState(() {
      _state = i;
      if (i > 2) {
        _navState = 1;
      } else {
        _navState = _state;
      }
    });
  }
  // code here

  static const List<Widget> _widgetOptions = <Widget>[
    Expanded(flex: 2, child: ChatFeed()),
    Expanded(flex: 2, child: HomeFeedView()),
    Expanded(flex: 2, child: MapView()),
    Expanded(flex: 2, child: CreateEventView()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: initTheme,
        home: (_authState)
            ? (Builder(
                builder: (context) => Scaffold(
                      appBar: AppBar(
                          title: const Text('Eventify',
                              style: const TextStyle(
                                color: Themes.first,
                              )),
                          backgroundColor: Themes.appBar,
                          flexibleSpace: SafeArea(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  IconButton(
                                      alignment: Alignment.center,
                                      onPressed: () => {
                                            _navState = _state,
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfilePage())).then(
                                                (_) => {
                                                      _stateCounter(_navState),
                                                      checkAuth()
                                                    }),
                                          },
                                      icon: Image.asset(
                                        "assets/images/user.png",
                                        color: Themes.first,
                                      )),
                                ]),
                          )),

                      // bottom navigation bar
                      bottomNavigationBar: BottomNavigationBar(
                        currentIndex: _navState,
                        type: BottomNavigationBarType.shifting,
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(Icons.format_list_bulleted),
                            label: 'Events',
                            backgroundColor: Themes.white,
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: 'Home',
                            backgroundColor: Themes.white,
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.map_outlined),
                            label: 'Map',
                            backgroundColor: Themes.white,
                          ),
                        ],
                        unselectedItemColor: Themes.third,
                        selectedItemColor: Themes.second,
                        onTap: _stateCounter,
                      ),
                      body: WillPopScope(
                          // TAKAISINNÄPPÄINPAINIKKEEN HALLINTA, muista näkymistä vie homeen ja homesta sulkee sovelluksen
                          onWillPop: () async {
                            if (_state != 1) {
                              setState(() {
                                //retrieve();
                                _state = _navState;
                              });
                              return false;
                            }
                            return true;
                          },
                          child: Column(
                              children: ([
                            _widgetOptions.elementAt(_state),

                            // TESTIPAINIKKEET
                            // TÄSTÄ ALASPÄIN KAIKKI KOODI POISTUU MYÖHEMMIN!!!!!!!!!!!!!
                          ]))),
                    )))
            : LoginPage(cb: retrieve));
  }

  /*void login(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => LoginView()),
    );
    print('result:' + result.toString());
    setState(() {
      _authState = true;
    });
  }*/
}

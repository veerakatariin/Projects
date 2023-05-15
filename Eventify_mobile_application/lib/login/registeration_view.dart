import 'package:email_validator/email_validator.dart';
import 'package:eventify_frontend/login/select_profile_picture.dart';
import 'package:flutter/material.dart';

import '../apis/controllers/login_controller.dart';

class RegisterationView extends StatefulWidget {
  final VoidCallback cb;
  const RegisterationView(this.cb, {Key? key}) : super(key: key);
  RegisterationViewState createState() => RegisterationViewState();
}

class RegisterationViewState extends State<RegisterationView> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  String picture = "assets/images/profile_pictures/default_image.png";

  final usernameCtrl = TextEditingController();

  final emailCtrl = TextEditingController();

  final passwdCtrl = TextEditingController();

  void _showPictureSelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const selectProfilePicture()),
    );
    setState(() {
      picture = result;
    });
    print('result:' + result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
                alignment: Alignment.topLeft,
                onPressed: (() => Navigator.pop(context)),
                icon: Icon(Icons.arrow_back)),
            const Text(
              'Sign up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            IconButton(
              icon: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: AssetImage(
                      picture,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              iconSize: 100,
              onPressed: () {
                _showPictureSelection(context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLines: 1,
                          controller: usernameCtrl,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Please enter a valid email",
                    maxLines: 1,
                    controller: emailCtrl,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: passwdCtrl,
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var status = await registerUser(usernameCtrl.text,
                          emailCtrl.text, passwdCtrl.text, picture);
                      print(status);
                      if (status == true) {
                        widget.cb();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*import 'package:eventify_frontend/apis/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class RegisterationView extends StatelessWidget {
  final VoidCallback cb;

  RegisterationView(this.cb, {Key? key}) : super(key: key);

  final usernameCtrl = TextEditingController();

  final emailCtrl = TextEditingController();

  final passwdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Eventify'),
      ),
      body: Container(
        color: Colors.grey,
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const Text(
            'Username:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            autofocus: false,
            textAlign: TextAlign.center,
            controller: usernameCtrl,
            autocorrect: false,
          ),
          const Text(
            'Email:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            autofocus: false,
            textAlign: TextAlign.center,
            controller: emailCtrl,
            autocorrect: false,
          ),
          const Text(
            'Password:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            autofocus: false,
            textAlign: TextAlign.center,
            controller: passwdCtrl,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          ElevatedButton(
            onPressed: () async {
              var status = await registerUser(
                  usernameCtrl.text, emailCtrl.text, passwdCtrl.text);
                  
              if (status == true) {
                cb();
                Navigator.pop(context);
              }
            },
            child: const Text('Submit'),
          ),
        ]),
      ),
    );
  }
}
*/

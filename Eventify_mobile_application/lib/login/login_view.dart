import 'package:email_validator/email_validator.dart';
import 'package:eventify_frontend/login/registeration_view.dart';
import 'package:flutter/material.dart';

import '../apis/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key, required this.cb}) : super(key: key);

  final VoidCallback cb;

  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  final emailCtrl = TextEditingController();
  final passwdCtrl = TextEditingController();

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
            const Text(
              'Sign in',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
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
                  CheckboxListTile(
                    title: const Text("Remember me"),
                    contentPadding: EdgeInsets.zero,
                    value: rememberValue,
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (newValue) {
                      rememberValue = newValue!;
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var status =
                          await loginUser(emailCtrl.text, passwdCtrl.text);
                      if (status == 'success') {
                        cb();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(status.toString())),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not registered yet?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RegisterationView(cb);
                          }));
                        },
                        child: const Text('Create an account'),
                      ),
                    ],
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
import 'package:eventify_frontend/login/registeration_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  //final bool cbfunction;
  final VoidCallback cb;

  LoginView(this.cb, {Key? key}) : super(key: key);

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
          color: Colors.blueGrey,
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
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
                var status = await loginUser(emailCtrl.text, passwdCtrl.text);
                if (status == 'success') {
                  cb();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(status.toString())),
                  );
                }
              },
              child: const Text('Submit'),
            ),
            const Spacer(),
            const Text("Don't have an account?"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RegisterationView(cb);
                  }));
                },
                child: const Text('Register')),
          ]),
        ));
  }
}
*/
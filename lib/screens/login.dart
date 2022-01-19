//largely based on https://github.com/itsmordecai/flash-chat/blob/master/lib/screens/login_screen.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';
import 'package:etransact/constants.dart';

class LogIn extends StatefulWidget {
  static const String id = 'login';

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log In")),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: kRoundedBorder,
                  fixedSize: kFixedSize,
                ),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    User? loggedUser = FirebaseAuth.instance.currentUser;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(uid: loggedUser!.uid)),
                        (Route<dynamic> route) => false);
                    setState(() {
                      showSpinner = false;
                    });
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email');
                      setState(() {
                        showSpinner = false;
                      });

                      Fluttertoast.showToast(
                        msg:
                            'No user found for that email. Re-enter credentials',
                      );
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user');
                      setState(() {
                        showSpinner = false;
                      });

                      Fluttertoast.showToast(
                        msg: 'Wrong password. Re-enter credentials',
                      );
                    } else {
                      print(e);
                      setState(() {
                        showSpinner = false;
                      });

                      Fluttertoast.showToast(
                        msg: 'Error. Try again!',
                      );
                    }
                  }
                },
                child: Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

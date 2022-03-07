//largely based on Flash Chat login screen

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
  final String title = "eTransact";

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool _isHidden = true;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        fontFamily: 'Roboto'),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextFormField(
                  obscureText: _isHidden,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    password = value;
                  },
                  onFieldSubmitted: (value) {
                    _performLogIn();
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: IconButton(
                        onPressed: _togglePasswordView,
                        icon: Icon(
                          _isHidden ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
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
                  onPressed: _performLogIn,
                  child: Text('Log In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  _performLogIn() async {
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
          MaterialPageRoute(builder: (context) => Home(uid: loggedUser!.uid)),
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
          msg: 'No user found for that email. Re-enter credentials',
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
  }
}

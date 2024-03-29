import 'package:flutter/material.dart';

import 'login.dart';
import 'signup.dart';
import 'package:etransact/constants.dart';

class LandingPage extends StatelessWidget {
  final String title = "eTransact";
  static const String id = 'landing_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: kRoundedBorder,
                    fixedSize: kFixedSize,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, SignUp.id);
                  },
                  child: Text('Create Account'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: kRoundedBorder,
                    fixedSize: kFixedSize,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, LogIn.id);
                  },
                  child: Text('Log In'),
                ),
              ),
            ]),
      ),
    );
  }
}

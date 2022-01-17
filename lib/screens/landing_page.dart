import 'package:flutter/material.dart';

import 'email_login.dart';
import 'email_signup.dart';
import 'package:e_transaction/constants.dart';

class LandingPage extends StatelessWidget {
  final String title = "eTransact";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(this.title),
      // ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        fontFamily: 'Roboto')),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: kRoundedBorder,
                    fixedSize: kFixedSize,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmailSignUp()),
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmailLogIn()),
                    );
                  },
                  child: Text('Log In'),
                ),
              ),
            ]),
      ),
    );
  }
}

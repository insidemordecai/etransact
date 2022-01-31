import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:etransact/screens/landing_page.dart';
import 'package:etransact/constants.dart';

class NavigateDrawer extends StatefulWidget {
  final String uid;
  NavigateDrawer({Key? key, required this.uid}) : super(key: key);

  @override
  _NavigateDrawerState createState() => _NavigateDrawerState();
}

class _NavigateDrawerState extends State<NavigateDrawer> {
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users"); // get users data

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // padding: EdgeInsets.zero, - it was this if parent was list view
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: FutureBuilder(
                future: dbRef.child(widget.uid).once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!.value['email'],
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    );
                  } else {
                    return CircularProgressIndicator(
                      color: Colors.white10,
                    );
                  }
                }),
            accountName: FutureBuilder(
                future: dbRef.child(widget.uid).once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!.value['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    );
                  } else {
                    return CircularProgressIndicator(
                      color: Colors.white10,
                    );
                  }
                }),
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home_rounded,
                    color: Colors.black,
                  ),
                  minLeadingWidth: 20,
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: kRoundedBorder,
                fixedSize: const Size(250, 30),
              ),
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                      (Route<dynamic> route) => false);
                });
              },
              child: Text('Log Out'),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

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
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: FutureBuilder(
                future: dbRef.child(widget.uid).once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.value['email']);
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
                    return Text(snapshot.data!.value['name']);
                  } else {
                    return CircularProgressIndicator(
                      color: Colors.white10,
                    );
                  }
                }),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

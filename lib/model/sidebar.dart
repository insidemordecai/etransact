import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NavigateDrawer extends StatefulWidget {
  final String uid;
  NavigateDrawer({Key? key, required this.uid}) : super(key: key);
  @override
  _NavigateDrawerState createState() => _NavigateDrawerState();
}

class _NavigateDrawerState extends State<NavigateDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("Users")
                    .child(widget.uid)
                    .once(),
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
                future: FirebaseDatabase.instance
                    .reference()
                    .child("Users")
                    .child(widget.uid)
                    .once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.value['name']);
                  } else {
                    return CircularProgressIndicator(
                      color: Colors.white10,
                    );
                  }
                }),
            // decoration: BoxDecoration(
            //   color: Colors.blue,
            // ),
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.home, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('Home'),
            onTap: () {
              print(widget.uid);
              Navigator.of(context).pop();
            },
          ),
          // ListTile(
          //   leading: new IconButton(
          //     icon: new Icon(Icons.settings, color: Colors.black),
          //     onPressed: () => null,
          //   ),
          //   title: Text('Settings'),
          //   onTap: () {
          //     print(widget.uid);
          //   },
          // ),
        ],
      ),
    );
  }
}
// End of Sidebar Drawer

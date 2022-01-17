import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NavigateDrawer extends StatefulWidget {
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
                future:
                    FirebaseDatabase.instance.reference().child("Users").once(),
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
                future:
                    FirebaseDatabase.instance.reference().child("Users").once(),
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
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
// End of Sidebar Drawer

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/home.dart';
import 'screens/landing_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // check for logged in user
    User result = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eTransact',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // if user is logged in go to home, if not -> landingpage
      home: result != null ? Home(uid: result.uid) : LandingPage(),
    );
  }
}

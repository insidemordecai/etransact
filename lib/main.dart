import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screens/home.dart';
import 'screens/landing_page.dart';
import 'model/palette.dart';
import 'package:etransact/screens/login.dart';
import 'package:etransact/screens/signup.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // check for logged in user
    User? result = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eTransact',
      theme: ThemeData(
        primarySwatch: Palette.kTeal,
      ),
      // if user is logged in go to home, if not -> landingpage
      home: result != null ? Home() : LandingPage(),
      routes: {
        LandingPage.id: (context) => LandingPage(),
        LogIn.id: (context) => LogIn(),
        SignUp.id: (context) => SignUp(),
        Home.id: (context) => Home(),
      },
    );
  }
}

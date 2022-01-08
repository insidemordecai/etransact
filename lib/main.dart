import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:splashscreen/splashscreen.dart';

import 'home.dart';
import 'landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    User result = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
      //initialize Flutterfire
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('Error in Firebase Initilisation');
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'eTransact',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: result != null ? Home(uid: result.uid) : LandingPage(),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}

// class IntroScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     User result = FirebaseAuth.instance.currentUser;
//     return new SplashScreen(
//         navigateAfterSeconds:
//             result != null ? Home(uid: result.uid) : LandingPage(),
//         seconds: 3,
//         title: new Text(
//           'Welcome To eTransact!',
//           style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//         ),
//         image: Image.asset('assets/images/dart.png', fit: BoxFit.scaleDown),
//         backgroundColor: Colors.white,
//         styleTextUnderTheLoader: new TextStyle(),
//         photoSize: 100.0,
//         onClick: () => print("flutter"),
//         loaderColor: Colors.red);
//   }
// }

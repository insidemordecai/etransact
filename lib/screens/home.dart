import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:pdf_viewer_jk/pdf_viewer_jk.dart';

import 'landing_page.dart';
import 'package:e_transaction/model/sidebar.dart';
import 'package:e_transaction/api/firebase_api.dart';
import 'package:e_transaction/model/firebase_file.dart';

class Home extends StatefulWidget {
  Home({this.uid});
  final String uid;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String title = "Home";
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('mordecai.kipngetich/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
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
          )
        ],
      ),
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles, 
        builder: (context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occured'),);
              } else {
                final files = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(files.length),
                    const SizedBox(height: 12,),
                    Expanded(
                      child: ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (context, index){
                          final file = files[index];

                          return buildFile(context, file);
                        }),),
                  ],
                );
              }
          }
        },),
      drawer: NavigateDrawer(uid: this.widget.uid),
    );
  }

    Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        leading: ClipOval(
          child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          file.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );
}

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'landing_page.dart';
import 'package:etransact/model/sidebar.dart';
import 'package:etransact/api/firebase_api.dart';
import 'package:etransact/model/firebase_file.dart';
import 'package:etransact/model/palette.dart';
import 'package:etransact/api/pdf_api.dart';
import 'package:etransact/screens/pdf_viewer.dart';

class Home extends StatefulWidget {
  Home({required this.uid});
  final String uid;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String title = "eTransact";
  late Future<List<FirebaseFile>> futureFiles;
  final String? userEmail = FirebaseAuth.instance.currentUser!.email;
  late String userDirectory;

  @override
  void initState() {
    super.initState();

    userDirectory = (userEmail! + '/');
    futureFiles = FirebaseApi.listAll(userDirectory);
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
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Some error occured'),
                );
              } else {
                final files = snapshot.data!;

                return RefreshIndicator(
                  onRefresh: _pullRefresh,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(files.length),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: files.length,
                            itemBuilder: (context, index) {
                              final file = files[index];

                              return buildFile(context, file);
                            }),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
      drawer: NavigateDrawer(uid: this.widget.uid),
    );
  }

  // update futureFiles with up-to-date data
  Future<void> _pullRefresh() async {
    List<FirebaseFile> freshFutureFiles =
        await FirebaseApi.listAll(userDirectory);
    setState(() {
      futureFiles = Future.value(freshFutureFiles);
    });
  }

  // create tiles for the data
  Widget buildFile(BuildContext context, FirebaseFile file) => Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        child: Card(
          child: ListTile(
            title: Text(
              file.name,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                // decoration: TextDecoration.underline,
                color: Colors.black,
              ),
            ),
            onTap: () async {
              final url = (userDirectory + file.name);
              final pdfFile = await PDFApi.loadFirebase(url);

              if (pdfFile == null) return;
              openPDF(context, pdfFile);
            },
          ),
        ),
      );

  // update header with number of files
  Widget buildHeader(int length) => ListTile(
        tileColor: Palette.kTeal,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length File(s)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );

  void openPDF(BuildContext context, File pdfFile) =>
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: pdfFile)),
      );
}

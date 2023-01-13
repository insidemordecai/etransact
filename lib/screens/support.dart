import 'package:flutter/material.dart';

class Support extends StatelessWidget {
  const Support({Key? key}) : super(key: key);

  static const String id = 'support';
  static const String title = 'eTransact';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'In case of any issue such as:',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: 24),
              Text(
                '- Password Reset',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
              ),
              Text(
                '- Profile Information Change',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
              ),
              Text(
                '- Etc.',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Contact admin at:',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: 24),
              Text(
                'contact@insidemordecai.com',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

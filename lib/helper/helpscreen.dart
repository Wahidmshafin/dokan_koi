import 'package:flutter/material.dart';
import 'components/body.dart';
import '../constants.dart';

class HelpScreen extends StatelessWidget {
  static String routeName = "/helpscereen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.91),
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Icon(
                Icons.help,
                color: kPrimaryColor,
              ),
            ),
            Text(
              "Help!!!",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        elevation: 2,
      ),
      body: Body(),
    );
  }
}

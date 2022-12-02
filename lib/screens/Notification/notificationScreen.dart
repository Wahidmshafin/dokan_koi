import 'package:dokan_koi/constants.dart';
import 'package:flutter/material.dart';
class Notify extends StatelessWidget {
  static String routeName = "/not";
  const Notify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Icon(Icons.notifications_none_rounded,color: kPrimaryColor,size: 30,),
            ),
            Text("Notification",style: TextStyle(color: Colors.black),),
          ],
        ),
        elevation: 2,
      ),
    );
  }
}

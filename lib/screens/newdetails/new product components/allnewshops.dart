import 'package:dokan_koi/constants.dart';
import 'package:flutter/material.dart';
class Allnewshops extends StatelessWidget {
  static String routeName = "/Allnewshops";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(Icons.storefront,color: kPrimaryColor,),
            ),
            Text("New Shops",style: TextStyle(color: Colors.black),
      ),
          ],
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.greenAccent,

        ),
      ),

    );
  }
}

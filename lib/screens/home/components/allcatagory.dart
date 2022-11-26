import 'package:flutter/material.dart';

class AllCatagory extends StatelessWidget {
  static String routeName = "/AllCatagory";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      appBar: AppBar(
        title: Text("Catagories",style: TextStyle(color: Colors.black),),
        elevation: 2,
      ),
    );
  }
}

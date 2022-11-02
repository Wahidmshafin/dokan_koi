import 'package:dokan_koi/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:dokan_koi/size_config.dart';

import '../../../components/default_button.dart';


class Print extends StatelessWidget {
  static String routeName = "/splash3";

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(child: Column(
                  children: [
                    Image.asset("assets/images/print.png"),
                    Text("Your Order List is ready to print",style: TextStyle(
                      fontSize: 30,fontWeight: FontWeight.bold,
                    ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 90,),
                    DefaultButton(
                      text: "Back To Home",
                      press: () {
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      },
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
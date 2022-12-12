import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/screens/Tutorial/tutorialpage.dart';
import 'package:dokan_koi/screens/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import '../../../helper/helpscreen.dart';
import '../../Notification/notificationScreen.dart';
import '../myaccount.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushNamed(context, MyAccount.routeName)
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {Navigator.pushNamed(context, Notify.routeName);},
          ),
          ProfileMenu(
            text: "Tutorials",
            icon: "assets/icons/play.svg",
            press: () {Navigator.pushNamed(context, TutorialScreen.routeName);},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {Navigator.pushNamed(context, HelpScreen.routeName);},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              await auth.signOut();
              // Navigator.popUntil(
              //     context, ModalRoute.withName(SplashScreen.routeName));
              Navigator.pushNamed(context, SplashScreen.routeName).then((value) => SystemNavigator.pop());
            },
          ),
        ],
      ),
    );
  }
}

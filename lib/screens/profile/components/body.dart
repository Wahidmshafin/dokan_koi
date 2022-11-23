import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/screens/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import '../../../helper/helpscreen.dart';
import '../myaccount.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  Position? location;
  final shop = FirebaseFirestore.instance.collection('shop');

  void getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      Position pos;
      var lastposition = await Geolocator.getLastKnownPosition();

      Fluttertoast.showToast(
        msg: " Location Updated ",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 20,
      );

      shop.doc(auth.currentUser?.uid).update({
        "lat": location?.latitude,
        "lon": location?.longitude,
      });
    }
    else {
      Fluttertoast.showToast(
        msg: " Turn on your location ",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 20,
      );
    }
  }

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
            text: "Update Location",
            icon: "assets/icons/Location point.svg",
            press: getCurrentLocation,
          ),
          // ProfileMenu(
          //   text: "Settings",
          //   icon: "assets/icons/Settings.svg",
          //   press: () {},
          // ),
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
              Navigator.popUntil(
                  context, ModalRoute.withName(SplashScreen.routeName));
            },
          ),
        ],
      ),
    );
  }
}

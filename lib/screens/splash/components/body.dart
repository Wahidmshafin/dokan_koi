import 'package:dokan_koi/constants.dart';
import 'package:dokan_koi/screens/home/home_screen.dart';
import 'package:dokan_koi/screens/sign_in/sign_in_screen.dart';
import 'package:dokan_koi/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import '../../../components/default_button.dart';
// This is the best practice
import '../components/splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  final auth=FirebaseAuth.instance;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Dokan Koi, Let's find your shop",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
      "Don't know where to find product? \nWe will help you!!",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  void getCurrentLocation() async{
    bool serviceEnabled=await Geolocator.isLocationServiceEnabled();
    if(serviceEnabled)
    {
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission==LocationPermission.denied)
      {
        permission=await Geolocator.requestPermission();
        if(permission==LocationPermission.denied)
        {
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        auth.authStateChanges().listen((event) {
                          if(event!=null)
                          {
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          }
                          else
                            {
                              Navigator.pushNamed(context, SignInScreen.routeName);
                            }
                        });

                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

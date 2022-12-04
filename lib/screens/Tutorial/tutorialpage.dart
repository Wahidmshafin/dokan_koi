import 'package:dokan_koi/size_config.dart';
import 'package:flutter/material.dart';

import '../../components/default_button.dart';
import '../../constants.dart';
import '../home/home_screen.dart';

class TutorialScreen extends StatefulWidget {
  static String routeName = "/tutorial";

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> splashData = [
      {
        "text": "Welcome to Dokan Koi, Let's find your shop",
        "image": "assets/images/1.png"
      },
      {
        "text": "Don't know where to find product? \nWe will help you!!",
        "image": "assets/images/2.png"
      },
      {
        "text": "We show the easy way to shop. \nJust stay at home with us",
        "image": "assets/images/3.png"
      },
      {
        "text": "We show the easy way to shop. \nJust stay at home with us",
        "image": "assets/images/4.png"
      },
      {
        "text": "We show the easy way to shop. \nJust stay at home with us",
        "image": "assets/images/7.png"
      },
      {
        "text": "We show the easy way to shop. \nJust stay at home with us",
        "image": "assets/images/9.png"
      },
    ];

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

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Expanded(
                flex: 3,
                child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) =>
                        Image.asset(splashData[index]["image"]!)),
              ),
              SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                              (index) => buildDot(index: index),
                        ),
                      ),
              SizedBox(height: 30,),
              SizedBox(
                width: getProportionateScreenWidth(350),
                child: DefaultButton(
                  text: "Continue",
                  press: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                    }),
              ),
              SizedBox(height: 30,)

            ],
          ),
        ),
      ),
    );
  }
}

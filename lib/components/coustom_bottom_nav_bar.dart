import 'package:dokan_koi/screens/Favourite/favourite_screen.dart';
import 'package:dokan_koi/screens/home/home_screen.dart';
import 'package:dokan_koi/screens/mystore/mystore.dart';
import 'package:dokan_koi/screens/profile/profile_screen.dart';
import 'package:dokan_koi/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon:Icon(Icons.home,
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor),
                // SvgPicture.asset(
                //   "assets/icons/Shop Icon.svg",
                //   color: MenuState.home == selectedMenu
                //       ? kPrimaryColor
                //       : inActiveIconColor,
                // ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName).whenComplete(() => Navigator.popUntil(context,ModalRoute.withName(SplashScreen.routeName))),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border_outlined,
                    color: MenuState.favourite == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor),//SvgPicture.asset("assets/icons/Heart Icon.svg"),
                onPressed: () {
                  Navigator.pushNamed(context, favscreen.routeName).whenComplete(() => Navigator.popUntil(context,ModalRoute.withName(SplashScreen.routeName)));
                },
              ),
              IconButton(
                icon: Icon(Icons.store_mall_directory_outlined,
                  color: MenuState.mystore == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor),
                onPressed:  () =>
                    Navigator.pushNamed(context, MyStore.routeName).whenComplete(() => Navigator.popUntil(context,ModalRoute.withName(SplashScreen.routeName))),
              ),
              IconButton(
                icon:Icon(Icons.person,
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor),
                // SvgPicture.asset(
                //   "assets/icons/User Icon.svg",
                //   color: MenuState.profile == selectedMenu
                //       ? kPrimaryColor
                //       : inActiveIconColor,
                // ),
                onPressed: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName).whenComplete(() => Navigator.popUntil(context,ModalRoute.withName(SplashScreen.routeName))),
              ),
            ],
          )),
    );
  }
}

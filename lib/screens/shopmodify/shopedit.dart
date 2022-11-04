import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import 'components/shopeditbody.dart';

class ShopEdit extends StatelessWidget {
  static String routeName = "/shopedit";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: shopeditbody(),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.mystore),
    );
  }
}

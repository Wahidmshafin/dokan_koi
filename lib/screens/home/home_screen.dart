import 'package:dokan_koi/components/coustom_bottom_nav_bar.dart';
import 'package:dokan_koi/enums.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";


  @override
  Widget build(BuildContext context) {
    print(DateTime.now().millisecondsSinceEpoch);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}

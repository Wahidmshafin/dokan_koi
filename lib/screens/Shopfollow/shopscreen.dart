import 'package:flutter/material.dart';
import 'package:dokan_koi/constants.dart';
import '../../models/Store.dart';
import '../../models/shops.dart';
import 'package:dokan_koi/screens/Shopfollow/Shop Components/shopbody.dart';
import '../details/components/custom_app_bar.dart';
import 'package:dokan_koi/components/coustom_bottom_nav_bar.dart';
class DetailsScreen3 extends StatelessWidget {
  static String routeName = "/details3";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments3 agrs =
    ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments3;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      body: Body(store: agrs.store),
    );
  }
}

class ProductDetailsArguments3 {
  final Store store;

  ProductDetailsArguments3({required this.store});
}

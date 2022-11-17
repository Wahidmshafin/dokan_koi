import 'package:dokan_koi/screens/Shopfollow/Shop Components/shopbody.dart';
import 'package:flutter/material.dart';

import '../../models/Store.dart';
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

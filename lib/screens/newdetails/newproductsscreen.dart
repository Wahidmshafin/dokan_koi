import 'package:flutter/material.dart';

import '../../models/Store.dart';
import '../../models/newproduct.dart';
import 'package:dokan_koi/screens/newdetails/new product components/body2.dart';
import '../details/components/custom_app_bar.dart';

class DetailsScreen2 extends StatelessWidget {
  static String routeName = "/details2";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments2 agrs =
    ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments2;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      //   child: CustomAppBar(rating: agrs.product.rating),
      // ),
      body: Body(store: agrs.store),
    );
  }
}

class ProductDetailsArguments2 {
  final Store store;

  ProductDetailsArguments2({required this.store});
}

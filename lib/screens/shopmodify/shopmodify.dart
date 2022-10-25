import 'package:flutter/material.dart';
import 'package:dokan_koi/constants.dart';
import '../../models/product.dart';
import 'components/shopmodifybody.dart';
import '../details/components/custom_app_bar.dart';
import 'package:dokan_koi/components/coustom_bottom_nav_bar.dart';
class ShopModify extends StatelessWidget {
  static String routeName = "/shopmodify";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments4 agrs =
    ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments4;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      //   child: CustomAppBar(rating: agrs.product.rating),
      // ),
      body: Body(product: agrs.product),
    );
  }
}

class ProductDetailsArguments4 {
  final Product product;

  ProductDetailsArguments4({required this.product});
}

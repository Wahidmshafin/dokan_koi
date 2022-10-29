import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../mystore/components/shop_add_button.dart';
import '../../mystore/components/store_header.dart';
class shopedit extends StatelessWidget {
  static String routeName = "/ShopEdit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(height: getProportionateScreenHeight(20)),
                  StoreHeader(),
                  SizedBox(height: getProportionateScreenWidth(30)),
                  Image.asset("assets/images/storefront.jpg"),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  AddShop(),
                ],
              ),
            ),
          ),
      );
  }
}

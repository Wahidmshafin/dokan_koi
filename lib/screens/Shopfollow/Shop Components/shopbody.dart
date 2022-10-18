import 'package:flutter/material.dart';
import 'package:dokan_koi/components/default_button.dart';
import 'package:dokan_koi/models/shops.dart';
import 'package:dokan_koi/size_config.dart';
import 'shopdescription.dart';
import '../Shop Components/roundedcontainer.dart';
import 'shopimage.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          ProductDescription(
            product: product,
            pressOnSeeMore: () {},
          ),
        ],
      ),
    );
  }
}

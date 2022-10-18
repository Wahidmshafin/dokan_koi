import 'package:flutter/material.dart';
import 'package:dokan_koi/components/product_card.dart';
import 'package:dokan_koi/models/Product.dart';

import '../../../size_config.dart';

class ShopProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ...List.generate(
            demoProducts.length,
                (index) {
              if (index<5) {
                return ProductCard(product: demoProducts[index]);
              }
              return SizedBox
                  .shrink(); // here by default width and height is 0
            },
          ),
        ],
      ),
    );
  }
}
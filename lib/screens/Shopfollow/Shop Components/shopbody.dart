import 'package:dokan_koi/models/Store.dart';
import 'package:dokan_koi/screens/Shopfollow/Shop%20Components/all_products.dart';
import 'package:flutter/material.dart';

import '../../details/details_screen.dart';
import 'shopdescription.dart';

class Body extends StatelessWidget {
  final Store store;

  const Body({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          ProductDescription(
            store: store,
            pressOnSeeMore: () {
              print("nothing wrong");
              Navigator.pushNamed(context, AllProducts.routeName,arguments: ProductDetailsArguments(id: store.id));
            },
          ),
        ],
      ),
    );
  }
}

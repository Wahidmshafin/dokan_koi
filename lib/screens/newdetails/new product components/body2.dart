import 'package:flutter/material.dart';

import '../../../models/Store.dart';
import '../../Shopfollow/Shop Components/all_products.dart';
import '../../details/details_screen.dart';
import 'shopdetailsforuser.dart';


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
              Navigator.pushNamed(context, AllProducts.routeName,arguments: ProductDetailsArguments(id: store.id));
            },
          ),
        ],
      ),
    );
  }
}
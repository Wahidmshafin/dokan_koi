import 'package:flutter/material.dart';
import 'package:dokan_koi/components/default_button.dart';
import 'package:dokan_koi/models/newproduct.dart';
import 'package:dokan_koi/size_config.dart';
import '../../../models/Store.dart';
import '../../Shopfollow/Shop Components/all_products.dart';
import 'newproductdescription.dart';
import '../new product components/newtoproundedcontainer.dart';
import 'newproductimage.dart';


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
              Navigator.pushNamed(context, AllProducts.routeName);
            },
          ),
        ],
      ),
    );
  }
}
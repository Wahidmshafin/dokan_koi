import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/Store.dart';
import '../../../size_config.dart';
import '../../Shopfollow/Shop Components/shops.dart';
import '../../Shopfollow/Shop Components/timeshop.dart';
import '../../newdetails/new product components/new_product.dart';
import 'home_header.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  final _shop = FirebaseFirestore.instance.collection('shop');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          HomeHeader(),
          SizedBox(height: getProportionateScreenWidth(10)),
          SpecialOffers(),
          SizedBox(height: getProportionateScreenWidth(30)),
          Newshops(),
          SizedBox(height: getProportionateScreenWidth(30)),
          NewProducts(),
          SizedBox(height: getProportionateScreenWidth(20)),
          Shops(),
          SizedBox(height: getProportionateScreenWidth(30)),
        ],
      )),
    );
  }
}

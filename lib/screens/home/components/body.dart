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
  List<Store> storeList = [];
  int? distance;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: _shop.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if(streamSnapshot.hasData)
              {
                for(int index = 0;index<streamSnapshot.data!.docs.length;index++){
                    storeList.add(
                        Store(
                          id: streamSnapshot.data!.docs[index]['id'],
                          description: streamSnapshot.data!.docs[index]
                          ['description'],
                          address: streamSnapshot.data!.docs[index]
                          ['address'],
                          images: [
                            streamSnapshot.data!.docs[index]['image']
                          ],
                          rating: streamSnapshot.data!.docs[index]['rating']
                              .toDouble(),
                          title: streamSnapshot.data!.docs[index]['name'],
                          district: streamSnapshot.data!.docs[index]
                          ['district'],
                          lat: streamSnapshot.data!.docs[index]['lat']
                              .toDouble(),
                          lon: streamSnapshot.data!.docs[index]['lon']
                              .toDouble(),
                          subDistrict: streamSnapshot.data!.docs[index]
                          ['subDistrict'],
                          type: streamSnapshot.data!.docs[index]['type'],
                          tpo: streamSnapshot.data!.docs[index]['tpo'],
                          tfo: streamSnapshot.data!.docs[index]['tfo'],
                        )
                    );
                }
              }
            return Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                HomeHeader(),
                SizedBox(height: getProportionateScreenWidth(10)),
                SpecialOffers(),
                SizedBox(height: getProportionateScreenWidth(30)),
                Newshops(),
                SizedBox(height: getProportionateScreenWidth(30)),
                NewProducts(storeList: storeList),
                SizedBox(height: getProportionateScreenWidth(20)),
                Shops(),
                SizedBox(height: getProportionateScreenWidth(30)),
              ],
            );
          }
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/new_card.dart';
import 'package:dokan_koi/screens/Shopfollow/Shop%20Components/mostpopularshop.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Store.dart';
import '../../../size_config.dart';
import '../../home/components/section_title.dart';
import '../../newdetails/new product components/allnewshops.dart';

class Shops extends StatelessWidget {
  final _shop = FirebaseFirestore.instance.collection('shop');
  final product = FirebaseFirestore.instance.collection("product");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "Popular Shops",
              press: () {
                Navigator.pushNamed(context, AllPopularShop.routeName);
              }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        StreamBuilder(
          stream: _shop.orderBy("tfo",descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              print("ok");
              return (streamSnapshot.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        width: double.infinity,
                        height: getProportionateScreenHeight(270),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:streamSnapshot.data!.docs.length<4?streamSnapshot.data!.docs.length:4,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: getProportionateScreenWidth(300),
                              child: Newcard(
                                store: Store(
                                  id: streamSnapshot.data!.docs[index]['id'],
                                  description: streamSnapshot.data!.docs[index]
                                      ['description'],
                                  address: streamSnapshot.data!.docs[index]
                                      ['address'],
                                  images: [
                                    streamSnapshot.data!.docs[index]['image']
                                  ],
                                  rating: streamSnapshot
                                      .data!.docs[index]['rating']
                                      .toDouble(),
                                  type: streamSnapshot.data!.docs[index]
                                      ['type'],
                                  lat: streamSnapshot.data!.docs[index]['lat']
                                      .toDouble(),
                                  lon: streamSnapshot.data!.docs[index]['lon']
                                      .toDouble(),
                                  title: streamSnapshot.data!.docs[index]
                                      ['name'],
                                  district: streamSnapshot.data!.docs[index]
                                      ['district'],
                                  subDistrict: streamSnapshot.data!.docs[index]
                                      ['subDistrict'],
                                  tpo: streamSnapshot.data!.docs[index]['tpo'],
                                  tfo: streamSnapshot.data!.docs[index]['tfo'], phone: streamSnapshot.data!.docs[index]['phone'],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
            }
            return const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          },
        )
      ],
    );
  }
}

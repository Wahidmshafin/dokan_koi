import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/new_card.dart';
import 'package:flutter/material.dart';

import '../../../models/Store.dart';
import '../../../size_config.dart';
import '../../home/components/section_title.dart';
class Shops extends StatelessWidget {
  final _shop = FirebaseFirestore.instance.collection('shop');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Shops", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        StreamBuilder(
          stream: _shop.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
            if(streamSnapshot.hasData)
            {
              print("ok");
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: double.infinity,
                  height: getProportionateScreenHeight(230),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context,index)=>Newcard(store: Store(
                        id: streamSnapshot.data!.docs[index]['id'],
                        description: streamSnapshot.data!.docs[index]['description'],
                        address: streamSnapshot.data!.docs[index]['address'],
                        images: [streamSnapshot.data!.docs[index]['image']],
                        rating: streamSnapshot.data!.docs[index]['rating'].toDouble(),
                        title: streamSnapshot.data!.docs[index]['name'],
                        district: streamSnapshot.data!.docs[index]['district'],
                        subDistrict: streamSnapshot.data!.docs[index]['subDistrict'])
                    ),
                  ),
                ),
              );
            }
            return const Center(
                child: CircularProgressIndicator());
          },
        )
      ],
    );
  }
}
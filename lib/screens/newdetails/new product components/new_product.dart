import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/new_card.dart';
import 'package:dokan_koi/models/Store.dart';
import 'package:dokan_koi/screens/newdetails/new%20product%20components/allnewshops.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../home/components/section_title.dart';
class NewProducts extends StatelessWidget {
  final _shop = FirebaseFirestore.instance.collection('shop');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "New Shops", press: () {
            Navigator.pushNamed(context, Allnewshops.routeName);
          }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        StreamBuilder(
          stream: _shop.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
            if(streamSnapshot.hasData)
              {
                print("ok");
                return (streamSnapshot.connectionState == ConnectionState.waiting)? Center(child: CircularProgressIndicator(color: kPrimaryColor,),):Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenHeight(250),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context,index)=>SizedBox(
                        width: getProportionateScreenWidth(240),
                        child: Newcard(store: Store(
                            id: streamSnapshot.data!.docs[index]['id'],
                            description: streamSnapshot.data!.docs[index]['description'],
                            address: streamSnapshot.data!.docs[index]['address'],
                            images: [streamSnapshot.data!.docs[index]['image']],
                            rating: streamSnapshot.data!.docs[index]['rating'].toDouble(),
                            title: streamSnapshot.data!.docs[index]['name'],
                            district: streamSnapshot.data!.docs[index]['district'],
                            lat: streamSnapshot.data!.docs[index]['lat'].toDouble(),
                            lon: streamSnapshot.data!.docs[index]['lon'].toDouble(),
                            subDistrict: streamSnapshot.data!.docs[index]['subDistrict'],
                            type: streamSnapshot.data!.docs[index]['type'],

                        )
                        ),
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
// Newcard(store: );
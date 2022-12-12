import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/constants.dart';
import 'package:flutter/material.dart';

import '../../../components/new_card.dart';
import '../../../models/Store.dart';
import '../../../size_config.dart';
class AllNewShop extends StatelessWidget {
  static String routeName = "/AllNewShop";
  final _shop = FirebaseFirestore.instance.collection('shop');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(Icons.storefront,color: kPrimaryColor,),
            ),
            Text("Newest Shop",style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        elevation: 2,
      ),
      body: StreamBuilder(
        stream: _shop.orderBy('time',descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData)
          {
            print("ok");
            return (streamSnapshot.connectionState == ConnectionState.waiting)? Center(child: CircularProgressIndicator(color: kPrimaryColor,),): Center(
              child: Container(
                width: getProportionateScreenWidth(350),
                height: getProportionateScreenHeight(670),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: streamSnapshot.data!.docs.length,

                  itemBuilder: (context,index)=>SizedBox(
                    width: getProportionateScreenWidth(200),
                    child: Newcard(store: Store(
                      id: streamSnapshot.data!.docs[index]['id'],
                      description: streamSnapshot.data!.docs[index]['description'],
                      address: streamSnapshot.data!.docs[index]['address'],
                      images: [streamSnapshot.data!.docs[index]['image']],
                      rating: streamSnapshot.data!.docs[index]['rating'].toDouble(),
                      type: streamSnapshot.data!.docs[index]['type'],
                      lat: streamSnapshot.data!.docs[index]['lat'].toDouble(),
                      lon: streamSnapshot.data!.docs[index]['lon'].toDouble(),
                      title: streamSnapshot.data!.docs[index]['name'],
                      district: streamSnapshot.data!.docs[index]['district'],
                      subDistrict: streamSnapshot.data!.docs[index]['subDistrict'],
                      tpo: streamSnapshot.data!.docs[index]['tpo'],
                      tfo: streamSnapshot.data!.docs[index]['tfo'], phone: streamSnapshot.data!.docs[index]['phone'],
                    ),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor,));
        },
      ),
    );
  }
}

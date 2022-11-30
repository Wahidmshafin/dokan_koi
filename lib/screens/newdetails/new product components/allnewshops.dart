import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/constants.dart';
import 'package:flutter/material.dart';

import '../../../components/new_card.dart';
import '../../../models/Store.dart';
import '../../../size_config.dart';
class Allnewshops extends StatelessWidget {
  static String routeName = "/Allnewshops";
  final _shop = FirebaseFirestore.instance.collection('shop');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(Icons.storefront,color: kPrimaryColor,),
            ),
            Text("New Shops",style: TextStyle(color: Colors.black),
      ),
          ],
        ),
        elevation: 2,
      ),
      body: StreamBuilder(
        stream: _shop.snapshots(),
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
                        subDistrict: streamSnapshot.data!.docs[index]['subDistrict']),
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

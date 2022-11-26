import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/favcard.dart';
import '../../constants.dart';
import '../../models/Store.dart';
import '../../size_config.dart';
class Body extends StatelessWidget {
   Body({
    Key? key,
     required this.Type,
  }) : super(key: key);
  final _shop = FirebaseFirestore.instance.collection('shop');
  final String Type;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _shop.where("type",isEqualTo:Type).snapshots(),
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
                itemBuilder: (context,index)=>Favcard(store: Store(
                  id: streamSnapshot.data!.docs[index]['id'],
                  description: streamSnapshot.data!.docs[index]['description'],
                  address: streamSnapshot.data!.docs[index]['address'],
                  images: [streamSnapshot.data!.docs[index]['image']],
                  rating: streamSnapshot.data!.docs[index]['rating'].toDouble(),
                  type: streamSnapshot.data?.docs[index]['type'],
                  title: streamSnapshot.data!.docs[index]['name'],
                  district: streamSnapshot.data!.docs[index]['district'],
                  subDistrict: streamSnapshot.data!.docs[index]['subDistrict'], lat: 0, lon: 0,),
                ),
              ),
            ),
          );
        }
        return const Center(
            child: CircularProgressIndicator());
      },
    );
  }
}

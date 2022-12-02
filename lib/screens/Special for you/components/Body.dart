import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/new_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Store.dart';
import '../../../size_config.dart';
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
            child: Scaffold(
              backgroundColor: Colors.white.withOpacity(0.6),
              appBar: AppBar(
                elevation: 2,
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Icon(Icons.dashboard_outlined,color: kPrimaryColor,),
                    ),
                    Text(Type,style: TextStyle(color: Colors.black),),
                  ],
                ),
              ),
              body: Center(
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
                        type: streamSnapshot.data?.docs[index]['type'],
                        title: streamSnapshot.data!.docs[index]['name'],
                        district: streamSnapshot.data!.docs[index]['district'],
                        subDistrict: streamSnapshot.data!.docs[index]['subDistrict'],
                        lat: streamSnapshot.data!.docs[index]['lat'].toDouble(),
                        lon: streamSnapshot.data!.docs[index]['lon'].toDouble(),
                        tfo: streamSnapshot.data!.docs[index]['tfo'],
                        tpo: streamSnapshot.data!.docs[index]['tpo']),
                      ),
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
    );
  }
}

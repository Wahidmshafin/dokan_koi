import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/new_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../components/favcard.dart';
import '../../constants.dart';
import '../../enums.dart';
import '../../models/Store.dart';
import '../../size_config.dart';
class favscreen extends StatelessWidget {
  static String routeName = "/favscreen";
  final _shop = FirebaseFirestore.instance.collection('favourite').doc(FirebaseAuth.instance.currentUser?.uid).collection('items');
  final fav =
  FirebaseFirestore.instance.collection("favourite").doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("items");
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: Text("My Favourites",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        //elevation: 3,

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
                        type: streamSnapshot.data?.docs[index]['type'],
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
              child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
}

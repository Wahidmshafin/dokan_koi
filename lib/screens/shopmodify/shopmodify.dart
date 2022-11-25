import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/models/Store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../details/components/custom_app_bar.dart';
import 'components/shopmodifybody.dart';



class ShopModify extends StatelessWidget {
  static String routeName = "/shopmodify";
  final _shop = FirebaseFirestore.instance.collection('shop');
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _shop.doc(_auth.currentUser?.uid).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final data = snapshot.data!.data();
          return (snapshot.connectionState == ConnectionState.waiting)? Center(child: CircularProgressIndicator(color: kPrimaryColor,),):Scaffold(
            backgroundColor: Colors.grey.withOpacity(0.09),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: CustomAppBar(rating: data!['rating']),
            ),
            body: Body(store: Store(
                id:data['id'],
                description: data['description'],
                address: data['address'],
                images: [data['image']],
                title: data['name'],
                district: data['district'],
                subDistrict: data['subDistrict'],
                rating: data['rating'].toDouble(),
                lat: data['lat'].toDouble(),
                lon: data['lon'].toDouble(),
            ),
            ),
          );
        }
        return const Center(
            child: CircularProgressIndicator());
      }
    );
  }
}


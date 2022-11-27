import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/components/product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ShopProducts extends StatelessWidget {

  FirebaseAuth auth = FirebaseAuth.instance;
  final _products =
  FirebaseFirestore.instance.collection('product');
  String id;
  ShopProducts({super.key,required this.id });

  @override
  Widget build(BuildContext context) {

    return Container(
      child: StreamBuilder(
          stream: _products.where("id",isEqualTo: id).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if(streamSnapshot.hasData)
            {
              return (streamSnapshot.connectionState == ConnectionState.waiting)? Center(child: CircularProgressIndicator(color: kPrimaryColor,),):SingleChildScrollView(
                child: Container(
                  height: getProportionateScreenHeight(300),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) => ProductCard(
                          id: streamSnapshot.data!.docs[index].id,
                          title: streamSnapshot.data!.docs[index]['title'],
                          price: streamSnapshot.data!.docs[index]['price'],
                          qty: streamSnapshot.data!.docs[index]['qty'],
                          image: streamSnapshot.data!.docs[index]['images'])
                  ),
                ),
              );
            }
            return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor,));
          }
      ),
    );
  }
}
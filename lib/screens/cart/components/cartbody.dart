import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/screens/cart/components/cart_card.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';


class CartItems extends StatelessWidget {

  final CollectionReference _products =
  FirebaseFirestore.instance.collection('cart');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: _products.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if(streamSnapshot.hasData)
            {
              return SingleChildScrollView(
                child: Container(
                  height: getProportionateScreenHeight(600),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) => CartCard(
                          id: streamSnapshot.data!.docs[index].id,
                          title: streamSnapshot.data!.docs[index]['title'],
                          price: streamSnapshot.data!.docs[index]['price'],
                          qty: streamSnapshot.data!.docs[index]['qty'],
                          image: streamSnapshot.data!.docs[index]['image'])
                  ),
                ),
              );
            }
            return const Center(
                child: CircularProgressIndicator());
          }
      ),
    );
  }
}

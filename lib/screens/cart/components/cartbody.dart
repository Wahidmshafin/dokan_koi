import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/screens/cart/components/cart_card.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';


class CartItems extends StatefulWidget {

  @override
  State<CartItems> createState() => _CartItemsState();
}


class _CartItemsState extends State<CartItems> {
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
                      itemBuilder: (context, index) => Dismissible(
                        background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE6E6),
                              borderRadius: BorderRadius.circular(15),
                            ),
                      ),
                        key: Key(streamSnapshot.data!.docs[index]['title']),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction){
                          setState(() async{
                            await _products.doc(streamSnapshot.data!.docs[index].id).delete();
                            print("ok");
                          });
                        },
                          child: CartCard(
                          id: streamSnapshot.data!.docs[index].id,
                          title: streamSnapshot.data!.docs[index]['title'],
                          price: streamSnapshot.data!.docs[index]['price'],
                          qty: streamSnapshot.data!.docs[index]['qty'],
                          image: streamSnapshot.data!.docs[index]['image']),
                  ),
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

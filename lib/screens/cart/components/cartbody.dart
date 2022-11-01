import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/screens/cart/components/cart_card.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'check_out_card.dart';


class CartItems extends StatefulWidget {
  static String routeName = "/cart";

  @override
  State<CartItems> createState() => _CartItemsState();
}


class _CartItemsState extends State<CartItems> {
  final CollectionReference _products =
  FirebaseFirestore.instance.collection('cart');
  var total=0;
//hello
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _products.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            total =0;
            if(streamSnapshot.hasData)
            { for (var element in streamSnapshot.data!.docs) {
              var va = element.data() as Map<String, dynamic>;
              total += va["price"] as int;
            }
            print(total);
              return Scaffold(
                backgroundColor: Colors.white.withOpacity(0.97),
                appBar: AppBar(
                  title: Column(
                    children: [
                      Text(
                        "Your Cart",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(

                        "${streamSnapshot.data!.docs.length} items",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: CheckoutCard(total: total,),
                body: SingleChildScrollView(
                  child: Container(
                    color: Colors.grey.withOpacity(0.05),
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
                          key: Key(streamSnapshot.data!.docs[index].id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction)
                          {
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


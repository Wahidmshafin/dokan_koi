import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
   CartCard({
    Key? key,
    required this.title,
    required this.price,
    required this.qty,
    required this.image,
    required this.id,
    //required this.product,
  }) : super(key: key);
   final CollectionReference _products =
  FirebaseFirestore.instance.collection('cart');
  // final double width, aspectRetio;
  //final Product product;
  final String image;
  final String title;
  final int price;
  final int qty;
  final String id;

   Future<void> _add(String productId) async {
     await _products.doc(productId).update({"qty":qty+1});
     print(productId);
   }
   Future<void> _delete(String productId) async {
     await _products.doc(productId).update({"qty":qty-1});
     print(productId);
   }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all( getProportionateScreenWidth(15)),
      child:SizedBox(
        width: double.infinity,
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Image.asset("assets/images/$image",height: 100,width: 100,),
              SizedBox(width: getProportionateScreenWidth(20),),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),maxLines: 1,overflow: TextOverflow.fade,softWrap: false,),
                  Text("Price: \৳${price}"),
                  Row(
                    children: [
                      OutlinedButton(onPressed: () { _add(id);},
                      child: Icon(CupertinoIcons.plus,size: 16,color: kPrimaryColor,)),
                      SizedBox(width: 5,),
                      Text("Qty: ${qty.toString()}"),
                      SizedBox(width: 5,),
                      OutlinedButton(onPressed: () { if(qty!=1){_delete(id);} },
                      child: Icon(CupertinoIcons.minus,size: 16,color: Colors.redAccent,)),
                    ],
                  ),
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
}



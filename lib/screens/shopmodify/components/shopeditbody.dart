import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'ShopEdit.dart';
class shopeditbody extends StatelessWidget {

  final _shop = FirebaseFirestore.instance.collection('shop');
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder(
        stream: _shop.doc(_auth.currentUser?.uid).snapshots(),
    builder: (context, snapshot) {
       return SafeArea(
         child: SingleChildScrollView(
             child: Column(
               children: [
                 // SizedBox(height: getProportionateScreenHeight(20)),
                // StoreHeader(),
                 SizedBox(height: getProportionateScreenWidth(30)),
                  shopedit(),

               ],
             ),
           ),
       );
    }
      );
  }
}

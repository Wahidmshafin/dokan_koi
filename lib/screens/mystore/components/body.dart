import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan_koi/screens/shopmodify/components/edit_form.dart';
import 'package:dokan_koi/screens/shopmodify/shopmodify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Body extends StatelessWidget {

  final _shop = FirebaseFirestore.instance.collection('shop');
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    bool bo=false;
     return StreamBuilder(
       stream: _shop.doc(_auth.currentUser?.uid).snapshots(),
       builder: (context, snapshot) {
         if(snapshot.data?.exists??false) {
           return ShopModify();
         }
         else
           {
             return ShopForm();
           }
       }
     );
  }

}


